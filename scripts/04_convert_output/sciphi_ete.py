#!/usr/bin/env python

import sys
filename = sys.argv[1]

from ete3 import Tree
t = Tree.from_parent_child_table([line.split() for line in open(filename)] )

nwk=t.write()

f = open("Out", "w")
f.write(nwk)
f.close()

