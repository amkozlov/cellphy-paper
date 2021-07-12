#!/usr/bin/env python
import sys
import random
import os
import operator

healthy_name = "healthycell"

iupac = {}
iupac['A'] = ['A']
iupac['C'] = ['C']
iupac['G'] = ['G']
iupac['T'] = ['T']
iupac['R'] = ['A', 'G']
iupac['Y'] = ['C', 'T']
iupac['S'] = ['G', 'C']
iupac['W'] = ['A', 'T']
iupac['K'] = ['G', 'T']
iupac['M'] = ['A', 'C']

gapchars = ['N', '-']

def homo(gt):
  if gt in ['A', 'C', 'G', 'T']:
    return True
  else:
    return False

def read_msa_file(msa_file, snv=False):
    seqs = {}
    names = []
    n_taxa = n_snv = 0
    with open(msa_file) as f:
        lnum = 0
        for line in f:
          lnum += 1
          if lnum == 1:
            toks = line.strip().split()
            n_taxa = int(toks[0])
            n_snv = int(toks[1])
          elif lnum == 2 and snv:
            # skip snv positions
            pos = map(int, line.split())
#            print pos
          else:
            (taxon, seq) = line.strip().split()
            names.append(taxon)
            seqs[taxon] = seq.upper()
            if len(seq) != n_snv:
                print "Error: invalid number of SNVs! (expected %d, got %d)" % (n_snv, len(seq))
                exit
            
    if len(seqs) != n_taxa:
        print "Error: invalid number of taxa!"
        exit

    if snv:
      return pos, names, seqs 
    else:
      return names, seqs
    
def write_msa_file(msa_file, names, seqs):
    with open(msa_file, "w") as fout:
      fout.write(str(len(seqs)) + " " + str(len(seqs[healthy_name])) + "\n")
      for name in names:
         fout.write(name + " " + seqs[name] + "\n")

def filter_trial_sites(snvs, root_snv):
   # detect multi-allelic sites
   n_snv_old = len(snvs[healthy_name])
   skip = [0] * n_snv_old
   n_skip = 0
   for i in range(n_snv_old):
     alleles = {}
     root_gt = root_snv[i]
     
     if len(iupac[root_gt]) > 1:
       print "ERROR: non-homozygous root genotype: ", root_gt
       
     # true root genotype (=REF allele) is always counted, 
     # even if it is not observed in the sequence data
     alleles[root_gt] = 1
     for (name, seq) in snvs.iteritems():
       c = seq[i]
       if c not in gapchars:
         for al in iupac[c]:
           alleles[al] = alleles.get(al, 0) + 1
     if len(alleles) > 2:
       skip[i] = 1
       n_skip = n_skip + 1
#       print "skip column ", i
    
   n_snv_new = n_snv_old - n_skip
   
   # filter multi-allelic sites
   new_snvs = {}

   for (name, seq) in snvs.iteritems():
     new_seq = [' '] * n_snv_new
     j = 0
     for i in range(len(seq)):
       if not skip[i]:
         new_seq[j] = seq[i]
         j = j + 1
   
     new_snvs[name] = ''.join(new_seq)
     
   return new_snvs

def convert_trial_to_gaps(snvs, root_snv):
   # determine two most frequent alleles for each site
   n_snv = len(snvs[healthy_name])
   major_als = [[]] * n_snv
   for i in range(n_snv):
     root_gt = root_snv[i]
     alleles = {}

     for (name, seq) in snvs.iteritems():
       c = seq[i]
       if c not in gapchars:
         for al in iupac[c]:
           if al <> root_gt:
             alleles[al] = alleles.get(al, 0) + 1
     sorted_als = sorted(alleles.items(), key=operator.itemgetter(1), reverse=True)

     # true root genotype (=REF allele) is always included, 
     # even if it is not observed in the sequence data
     if sorted_als:
        major_als[i] = root_gt + sorted_als[0][0]
     else:
        major_als[i] = root_gt

#   print "MAJOR ALS: ", major_als[0]
         
   # remove minor alleles
   new_snvs = {}
   for (name, seq) in snvs.iteritems():
     new_seq = [' '] * n_snv
     for i in range(len(seq)):
       c = seq[i]
       if c in gapchars:
         new_seq[i] = c
       elif homo(c):
         if c in major_als[i]:
           new_seq[i] = c
         else:
           new_seq[i] = '-'
       else:  # hetero
         als = iupac[c]
         if als[0] in major_als[i] and als[1] in major_als[i]:
            new_seq[i] = c
#         elif als[0] in major_als[i]:
#          new_seq[i] = als[0]
#         elif als[1] in major_als[i]:
#           new_seq[i] = als[1]
         else:
           new_seq[i] = '-'
         
     new_snvs[name] = ''.join(new_seq)
       
   return new_snvs
       
if __name__ == "__main__":
    if len(sys.argv) == 1: 
        print "Usage: ./snv2infSCITE.py snv_hap.phy true_hap.phy [keep | remove | missing]"
        sys.exit()

    snv_file = sys.argv[1]
    true_hap_file = sys.argv[2]

    trial_mode = "keep" 
    if len(sys.argv) > 3:
      trial_mode = sys.argv[3]

    if trial_mode == "skip":
      trial_mode = "remove"
    elif trial_mode == "gap":
      trial_mode = "missing"

    infscite_file = snv_file + "." + trial_mode + ".inf"
    names_file = snv_file + "." + trial_mode + ".names"
    filtered_file = snv_file + "." + trial_mode + ".filtered"

    (pos, names, snvs) = read_msa_file(snv_file, True)
    tnames, true_haps = read_msa_file(true_hap_file, False)
    root_seq = true_haps[healthy_name]

    for i in range(len(root_seq)):
      if len(iupac[root_seq[i]] ) > 1:
        print "Find heterozygous reference genotype: ", root_seq[i]
        print "This is currently not allowed!"
        sys.exit()
    
    root_snv = [' '] * len(pos)
    for i in range(len(pos)):
      root_pos = pos[i]-1
      root_snv[i] = root_seq[root_pos]
    root_snv = ''.join(root_snv)
    
    if trial_mode == "remove":
      snvs = filter_trial_sites(snvs, root_snv)
    elif trial_mode == "missing":
      snvs = convert_trial_to_gaps(snvs, root_snv)
    elif trial_mode <> "keep":
      print "Invalid tri-allelic site processing mode: ", trial_mode
      sys.exit()
    
    write_msa_file(filtered_file, names, snvs)
    
    n_taxa = len(snvs)
    n_snv = len(snvs[healthy_name])
    
    infscite_mat = [[0 for x in range(n_taxa)] for y in range(n_snv)] 
    
    with open(names_file, "w") as fname:
        j = 0  
        for name in names:
           seq = snvs[name]
           fname.write(name + " ")
           for i in range(len(seq)):
             root_gt = root_snv[i]
             cell_gt = seq[i]
             if root_gt in gapchars or cell_gt in gapchars:
               mt = 3   # missing data
             elif root_gt == cell_gt:
               mt = 0   # reference genotype
             elif homo(cell_gt):
               mt = 2   # homozygous alternative
             else:
               mt = 1   # heterozygous
             infscite_mat[i][j] = mt
           j += 1

    with open(infscite_file, "w") as fseq:
        for i in range(n_snv):
#            fseq.write("%d " % (i+1))
            for j in range(n_taxa):
              fseq.write("%d" % infscite_mat[i][j]);
              if j < n_taxa-1:
                fseq.write(" ") 
            fseq.write("\n") 
    
    print "Names: ", names_file
    print "infSCITE mutation matrix: ", infscite_file
