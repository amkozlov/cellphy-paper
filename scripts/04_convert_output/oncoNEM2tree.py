#!/usr/bin/env python2
# -*- coding: utf-8 -*-
import dendropy
import sys
import re

if len(sys.argv) < 3:
  print "Usage: oncoNEM2tree.py <EdgeList> <CellPops>"
  sys.exit()

edges_fname = sys.argv[1]
cells_fname = sys.argv[2]

# Read Edge list
infile = open(edges_fname,'r')
lines = [line.rstrip('\n') for line in infile]
edge_list = []

for pair in lines:
    nums = pair.split(",")
    numst = [int(x) for x in nums]
    edge_list.append([numst[0],numst[1]])

node_dict = {}
tree = dendropy.Tree()

# build a mutation tree from edge list
for e in edge_list:
  pid = e[0]
  cid = e[1]
  # create parent node, if not exists already
  if not pid in node_dict:
    node_dict[pid] = dendropy.Node(label=pid) 
  pnode = node_dict[pid]
  # child node, if not exists already
  if not cid in node_dict:
    node_dict[cid] = dendropy.Node(label=cid) 
  cnode = node_dict[cid]
  # attach child to parent
  cnode.edge_length=1
  pnode.add_child(cnode)

#print node_dict, "\n"

# attach top level nodes to the root
for i, node in node_dict.iteritems():
  if not node.parent_node:
     tree.seed_node.add_child(node)

#print tree.as_string("newick", suppress_leaf_node_labels=False)

# Read cell names
cell_names = open(cells_fname).readlines()
cell_names=[line.rstrip('\n ') for line in cell_names]

#if len(cell_names) <> len(node_dict):
#  print "ERROR: Wrong number of entries in cell name file: ", sys.argv[3]

# attach cells to mutation tree nodes
for i in range(len(cell_names)):
   node = node_dict[i+1]
   cells = cell_names[i].strip("()").split(",")
   if node.is_leaf():
     if len(cells) == 1:
       # single cell at tip node -> just change name name
       node.label = cells[0]
     else:
       # multiple cells at tip node -> just attach cells immediately to the tip node
       for c in cells:
         node.new_child(label=c, edge_length=0)
   else:
     new_node = node.parent_node.new_child()
     node.parent_node.remove_child(node)
     new_node.add_child(node)
     if len(cells) == 1:
       # single cell at internal node -> add new tip with zero branch
       new_node.new_child(label=cells[0], edge_length=0)
     else:
       # multiple cells at internal node -> create extra node to keep cells together 
       gnode = new_node.new_child(edge_length=0)
       for c in cells:
         gnode.new_child(label=c, edge_length=0)

if edges_fname.endswith(".Edges"):
   outfname = edges_fname[:-len(".Edges")]
else:
   outfname = edges_fname

outfname += ".Tree.newick"
with open(outfname, "w") as outf:
  outf.write(tree.as_string("newick", suppress_leaf_node_labels=False))

