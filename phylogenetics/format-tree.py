#!/usr/bin/env python
"""format-tree.py: A script to create a formatted tree from RaxML input files
   and csv metadata files
"""

import itertools
import argparse

import ete3
import palettable

def myparser():
    """Parse input arguments.
    """

    parser = argparse.ArgumentParser(description='format-tree.py: A python script to format Trees \
        trim ITS amplicon sequences from Fastq files.')
    parser.add_argument('--tree', '-t', type=str, required=True,
                        help='A RAxML_bipartitions tree file in Newick format')
    parser.add_argument('--metadata', '-m', type=str, required=True,
                        help='A csv file containing environmental metadata')
    parser.add_argument('--output', '-o', required=True,
                        help='The path and filename to the output image')
    parser.add_argument('--format', '-f', choices=['svg', 'pdf', 'png'],
                        help='Output file format', default='pdf')
    parser.add_argument('--units', '-u', choices=['px', 'mm', 'in'], default='mm',
                        help='Units for size of output file')
    parser.add_argument('--width', default=165.1, type=int,
                        help='vt_line_width of output file')
    return parser
def read_metadata(filename, skip, treename):
    """ Read the metadata csv file and return values ad a dictionary

    """
    temptreedict = {}
    with open(filename, 'r') as f:
        result = itertools.islice(f, skip, None)
        for line in result:
            ll = line.strip().split(",")
            if ll[0] == treename:
                temptreedict[ll[4]] = {'tree':ll[0], 'tax':ll[1], 'genome':ll[2],
                                       'protein':ll[3], 'fullname':ll[5],
                                       'genus':ll[6],
                                       'host_phylum':ll[7], 'host_order':ll[8],
                                       'host_class':ll[9],'host_common_name':ll[10], 'new':ll[11]}
    return temptreedict


def _color_ancestor_nodes(treedict, tree):
    """Colors the tree by genus, based on metadata file

    """
    genusdict = {}
    nodelist = []
    for key, val in treedict.items():
        if not val['genus'] in genusdict:
            genusdict[val['genus']] = [key]
        else:
            genusdict[val['genus']].append(key)
    collist = palettable.colorbrewer.qualitative.Pastel1_9.hex_colors
    n = 0
    for k2, v2 in genusdict.items():
        if not k2 == 'Unassigned':
            ca = tree.get_common_ancestor(v2)
            if not tree == ca: # don't color a tree is it has only one genus
                # ca.add_face(ete3.faces.TextFace( k2, fsize=8),column=0, position='branch-top')
                ns = ete3.NodeStyle()
                ns["bgcolor"] = collist[n]
                ns['hz_line_width'] = 1
                ns['vt_line_width'] = 1
                ns['size'] = 0
                n += 1
                ca.set_style(ns)

def main(args=None):
    if not args:
        parser = myparser()
        args = parser.parse_args()
    tree = ete3.Tree(args.tree)
    rooting = tree.get_midpoint_outgroup()
    tree.set_outgroup(rooting)
    treename = args.tree.split(".")[-1]
    treedict = read_metadata(filename=args.metadata, skip=1, treename=treename)

    def layout(node):
        """Function to define the layout style

        """
        if node.is_leaf():
            ete3.faces.add_face_to_node(ete3.faces.TextFace(
                treedict[node.name]['host_class'], fgcolor='grey',fsize=7), node, column=0, aligned=True)
            if treedict[node.name]["new"] == 'TRUE':
                ete3.faces.add_face_to_node(ete3.faces.TextFace(
                    treedict[node.name]['fullname'], fgcolor='darkred', fsize=8), node,
                    column=1, aligned=True)
            else:
                ete3.faces.add_face_to_node(ete3.faces.TextFace(
                    treedict[node.name]['fullname'], fsize=8), node, column=1, aligned=True)


    ts = ete3.TreeStyle()
    ts.show_leaf_name = False
    ts.layout_fn = layout
    ts.show_branch_support = True
    ts.complete_branch_lines_when_necessary = True
    ts.draw_guiding_lines = False
    ts.scale_length=0.5


    ns = ete3.NodeStyle()
    ns['hz_line_width'] = 1
    ns['vt_line_width'] = 1
    ns['size'] = 0
    for n in tree.traverse():
        n.set_style(ns)

    _color_ancestor_nodes(treedict, tree)

    tree.render(args.output + "." + args.format, tree_style=ts)


if __name__ == "__main__":
    main()
