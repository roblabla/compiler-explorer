#!/bin/sh

GHIDRADIR=/Applications/ghidra_9.0/
BASEDIR=`dirname "$0"`

# Cross-platform (Darwin/Linux) mktemp
function mktempdir() {
    mktemp -d "$@.XXXXXXXXXX" 2>/dev/null || mktemp -d -t "$@"
}
function mktempfile() {
    mktemp "$@.XXXXXXXXXX" 2>/dev/null || mktemp -t "$@"
}

out_asm_file=`mktempfile "decompiler_explorer_out_asm"`
ghidra_project=`mktempdir "decompiler_explorer_ghidra"`

$GHIDRADIR/support/analyzeHeadless $ghidra_project temp -import $1 -postScript $BASEDIR/DecompilerExplorer.java $out_asm_file 1>&2
cat $out_asm_file

rm $out_asm_file
rm -rf $ghidra_project
