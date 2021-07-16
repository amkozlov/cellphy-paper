#!/usr/bin/env python
import sys
import random
import os
import dendropy
from dendropy.calculate import treecompare

iscite_tree_pat = "%s/iscite_trees/%s/snv_hap.%04d_ml%d.final-end.newick"

if __name__ == "__main__":
    if len(sys.argv) == 1: 
        print "Usage: ./compdist.py simdir model tool [avg/min]"
        sys.exit()

    sim_dir = sys.argv[1]

    if len(sys.argv) > 2:
      models = [sys.argv[2]]
    else:
      models = ["GTGTR4+FO+E"]

    if len(sys.argv) > 3:
     tool = sys.argv[3]
    else:
      tool = "rxsnv"

    rfmin_mode = False
    if len(sys.argv) > 4:
      if sys.argv[4] == "min" and tool in ["iscite", "tnt"]:
         rfmin_mode = True

    trees = 0
    sum_rf = 0
    sum_nrf = 0
    sum_eu = 0
    sum_neu = 0
    sum_tl_ratio = 0
    
    model = models[0]
    print model
    out_fname = "%s/dist_%s.csv" % (sim_dir, model)
    outmin_fname = "%s/distmin_%s.csv" % (sim_dir, model)
    with open(out_fname, "w") as f:
      f.write("rep\tRF\tnRF\tRFL\tnRFL\ttreelen_ratio\n");
      if rfmin_mode:
        fm = open(outmin_fname, "w")
        fm.write("rep\tRF\tnRF\tRFL\tnRFL\ttreelen_ratio\n");
      for i in range(1, 1000):
        if tool == "rxfull":
          itree_fname = "%s/rxfull_trees/%s/t%04d.raxml.bestTree" % (sim_dir, model, i)
        elif tool == "rxsnv":
          itree_fname = "%s/rxsnv_trees/%s/t%04d.raxml.bestTree" % (sim_dir, model, i)
        elif tool == "rxmlgt":
          itree_fname = "%s/rxmlgt_trees/%s/t%04d.raxml.bestTree" % (sim_dir, model, i)
        elif tool == "rxmlgp":
          itree_fname = "%s/rxmlgp_trees/%s/t%04d.raxml.bestTree" % (sim_dir, model, i)
        elif tool == "rxvcf":
          itree_fname = "%s/rxvcf_trees/%s/t%04d.raxml.bestTree" % (sim_dir, model, i)
        elif tool == "rxvcfn":
          itree_fname = "%s/rxvcfn_trees/%s/t%04d.raxml.bestTree" % (sim_dir, model, i)
        elif tool == "rxbin":
          itree_fname = "%s/rxbin_trees/%s/t%04d.raxml.bestTree" % (sim_dir, model, i)
        elif tool == "scite":
          itree_fname = "%s/scite_trees/%s/snv_hap.%04d_final.end.newick" % (sim_dir, model, i)
        elif tool == "iscite":
          #itree_fname = "%s/iscite_trees/%s/t%04d_final.newick" % (sim_dir, model, i)
          itree_fname = iscite_tree_pat % (sim_dir, model, i, 0)
        elif tool == "tnt":
          itree_fname = "%s/tnt_trees/%s/snv_hap.%04d.TNT.Tree.newick" % (sim_dir, model, i)
        elif tool == "onem":
          itree_fname = "%s/onem_trees/%s/snv_hap.%04d.Tree.newick" % (sim_dir, model, i)
        elif tool == "sifit":
          itree_fname = "%s/sifit_trees/%s/sifit.tree.%04d" % (sim_dir, model, i)
        elif tool == "sciphi":
          itree_fname = "%s/sciphi_trees/%s/%04d.SCiPhi.Tree.nwk" % (sim_dir, model, i)
        else:
          print "Unknown tool: ", tool
          sys.exit()

        rtree_fname = "%s/trees_dir/trees.%04d" % (sim_dir, i)
#        print tree1_fname
        if (not os.path.isfile(rtree_fname) or not os.path.isfile(itree_fname)):
#          print "WARNING: tree %d is missing and will be skipped!" % i
          continue
        
        if tool == "tnt2":
          fmt = "nexus"
        else:
          fmt = "newick"
       
        tree_list = dendropy.TreeList()
        tree_list.read(path=rtree_fname, schema="newick", rooting="force-unrooted")

        if len(tree_list) <> 1:
          print "Invalid reference tree: ", rtree_fname
          sys.exit()

        rtree=tree_list[0]
        rtaxa = len(rtree.leaf_nodes())
        rbranches = len(rtree.internal_nodes(True)) - 1
        maxrf = 2 * (rtaxa - 3)

        if rbranches <> rtaxa - 3:
          print "Invalid number of splits: ", rbranches, rtaxa - 3
          sys.exit()

        if tool == "iscite":
           for t in range(0,5000):
             itree_fname = iscite_tree_pat % (sim_dir, model, i, t)
             if os.path.isfile(itree_fname):
               tree_list.read(path=itree_fname, schema=fmt, rooting="force-unrooted")
             else:
               break
        else:
          tree_list.read(path=itree_fname, schema=fmt, rooting="force-unrooted")
  
        if len(tree_list) < 2:
          print "Invalid inferred tree: ", itree_fname
          sys.exit()

        opt_trees = 0
        dist_rf = 0
        dist_eu = 0
        dist_neu = 0
        tl_ratio = 0
        min_dist_rf = maxrf
        ibranches = 0
        for t in range(1, len(tree_list)):
          itree=tree_list[t]

          itaxa = len(itree.leaf_nodes())
          if rtaxa <> itaxa:
            print "ERROR: tree ", i, " has invalid number of taxa: ", itaxa, "(expected: ", rtaxa, ")"
            continue

          if ibranches == 0:
            ibranches = len(itree.internal_nodes(True))-1
          elif ibranches <> len(itree.internal_nodes(True))-1:
            print "ERROR: different resolution level in inferred trees!"
            sys.exit()

          this_rf = treecompare.symmetric_difference(rtree, itree)
          dist_rf += this_rf
          if this_rf < min_dist_rf:
            min_dist_rf = this_rf
          
          # some tools do not estimate branch lengths! 
          if tool not in ["tnt", "scite", "iscite", "onem"]:
            dist_eu += treecompare.euclidean_distance(rtree, itree)

            tl_ratio += itree.length() / rtree.length()
            itree.scale_edges(1 / tl_ratio)
            dist_neu += treecompare.euclidean_distance(rtree, itree)

          opt_trees += 1
   
        maxrf_poly = rbranches + ibranches
  
        if tool == "onem":
          maxrf = maxrf_poly

#        if tool not in ["onem"] and maxrf_poly <> maxrf:
#          print "Multifurcating tree found for a method other than oncoNEM: ", i, maxrf_poly, maxrf, rbranches, ibranches
#          sys.exit()

        if rfmin_mode:
          fm.write("%d\t%f\t%f\t%f\t%f\t%f\n" % (i, float(min_dist_rf), float(min_dist_rf)/maxrf, 0, 0, 0));
        
        # compute average over all optimal trees
        [dist_rf, dist_eu, tl_ratio, dist_neu ] = [ a / opt_trees for a in [float(dist_rf), dist_eu, tl_ratio, dist_neu]]

#        dist = true_tre.robinson_foulds_distance(raxml_tre)
#        (dist_fp, dist_fn) = tree1.false_positives_and_negatives(tree2)

        dist_nrf = float(dist_rf) / maxrf

#        dist_neu = tree1.euclidean_distance(tree2)

        trees += 1
        sum_rf += dist_rf
        sum_nrf += dist_nrf
        sum_eu += dist_eu
        sum_neu += dist_neu 
        sum_tl_ratio += tl_ratio

        f.write("%d\t%f\t%f\t%f\t%f\t%f\n" % (i, dist_rf, dist_nrf, dist_eu, dist_neu, tl_ratio));

#        print dist_fp, dist_fn, dist_rf, dist_nrf

      if rfmin_mode:
        fm.close()
     
    [avg_rf, avg_nrf, avg_eu, avg_neu, avg_tl_ratio] = [a / trees for a in [float(sum_rf), sum_nrf, sum_eu, sum_neu, sum_tl_ratio]]

    print "Trees: %d" % trees
    print "AVG: RF / RRF / RFL / nRFL / TreeLenRatio: %f %f %f %f %f" % (avg_rf, avg_nrf, avg_eu, avg_neu, avg_tl_ratio)
#    print "Length: t1 / t2 / ratio: %f %f %f" % (tree1.length(), tree2.length(), tl_ratio)
