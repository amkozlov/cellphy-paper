#! /usr/bin/env perl
#
# taxnameconvert
#
# a tool to convert taxon names within PHYLIP format tree files.
#
# (c) 2004-2005 by Heiko A. Schmidt
# (c) 2000-2003 by Heiko A. Schmidt (old name: abbr2name)
# 

use strict;
use warnings;

my $PACKAGENAME="taxnameconvert";
my $PACKAGEVERSION="2.4";

# $#ARGV
my $numargs = scalar(@ARGV);
my $progname = $0;

if ($numargs < 1) {
   printusage();
   exit 1;
}

my $fromtab = 0;
my $totab   = 1;
my $quote   = 0;
my $dbfile  = "";
my $trfile  = "";
my $outfile = "";
my $redirout = 0;
my $keepblanks = 0;

   my $n = 0;
   my $filenum = 0;
   my $flagused = 0;
   while ($n < $numargs) {
       my $arg = $ARGV[$n];
       my $tmp;
       $flagused = 0;
       $arg =~ s/^\s*//;
       $arg =~ s/\s*$//;

       $n++;

       if ((! $flagused) && ($arg =~ /^-h/)) {
          $flagused = 1;
          printusage();
          exit 1;
       }
       if ((! $flagused) && ($arg =~ /^-f/)) {
          $flagused = 1;
	  $arg =~ s/^-f\s*//;
          if ($arg eq "") { $arg = $ARGV[$n]; $n++; }
          $fromtab = $arg - 1;
       }
       if ((! $flagused) && ($arg =~ /^-t/)) {
          $flagused = 1;
	  $arg =~ s/^-t\s*//;
          if ($arg eq "") { $arg = $ARGV[$n]; $n++; }
          $totab = $arg - 1;
       }
       if ((! $flagused) && ($arg =~ /^-Q/)) {
          $flagused = 1;
	  $arg =~ s/^-Q\s*//;
          if ($arg eq "") { $arg = $ARGV[$n]; $n++; }
          $quote = $arg;
       }
       if ((! $flagused) && ($arg =~ /^-b/)) {
          $flagused = 1;
          $keepblanks = 1;
       }
       if ((! $flagused) && ($arg =~ /^-/)) {
          $flagused = 1;
             print STDERR "Warning: unknown flag '$arg' - ignored!!!\n\n";
       }
       if (! $flagused) {
          if ($filenum == 0) {
             $dbfile  = $arg;
             $filenum ++;
          } elsif ($filenum == 1) {
             $trfile  = $arg;
             $filenum ++;
          } elsif ($filenum == 2) {
             $outfile = $arg;
             $filenum ++;
             $redirout = 1;
          } else {
             die "Error: too many input files!!!\n";
          }
       }
   }

# my $fromtab=$ARGV[0] - 1;
# my $totab=$ARGV[1] - 1;
# my $quote=$ARGV[2];
# my $dbfile=$ARGV[3];
# my $trfile=$ARGV[4];
# my $outfile=$ARGV[5];


if ($redirout) {
	open (STDOUT, ">$outfile") or die "Error: Can't open $outfile!!!"; 
}
my $qqq= "\'";
if ($quote == 0) { $qqq="" };
if ($quote == 2) { $qqq="\"" };

printparams();

open (DB, "$dbfile") or die "Error: Can't open $dbfile!!!"; 
print STDERR "Conversion Table:\n";
print STDERR "-----------------\n";

my %sp;
my $dbcount = 0;

while (<DB>) {
   $dbcount ++;
   chomp;
   # ($abbr, $species) = ($_ =~ /([\w\.]+)\s+(.*)/);
   #($abbr, $comment ,$species ,$other) = ($_ =~ /([\S]+)\s+([\S]+)\s+([\S]+)\s+(.*)/);

   my $abbr;
   my $comment;
   my $species;
   my $specieslong;
   my $intab;
   my $outtab;
   my @cols;
   @cols = split(/\t/,$_);

   if (($fromtab < 0) || ($fromtab >= scalar(@cols))) 
      { die "from-column number $fromtab out of range (line $dbcount)!!!"; }
   if (($totab < 0) || ($totab >= scalar(@cols))) 
      { die "to-column number $totab out of range (line $dbcount)!!!"; }

   if (! $keepblanks) {
      $cols[$fromtab] =~ s/\s+$//;
      $cols[$fromtab] =~ s/^\s+//;
      $cols[$totab] =~ s/\s+$//;
      $cols[$totab] =~ s/^\s+//;
   }

   if ($cols[$fromtab] eq "") {die "empty entry in column $fromtab, line $dbcount!!!"; }
   if ($cols[$totab] eq "") {die "empty entry in column $totab, line $dbcount!!!"; }
   $sp{$cols[$fromtab]}=$cols[$totab];
   my $n = 1;
   print STDERR "'".$cols[$n - 1]."' ";
   while ($n < scalar(@cols)) {
       print STDERR "| '".$cols[$n]."' ";
       $n++;
   }
   print STDERR "\n";
}
close(DB);
print STDERR "\n";

my $line;
my $abbr;

undef $/;
open (TREE, "$trfile") or die "Error: Can't open $trfile!!!"; 
$line = <TREE>;
for $abbr (keys %sp) {
   if (! $keepblanks) {
      $line =~ s/[\'\"]*\s*\b($abbr)\s*[\'\"]*[ \t]*([\[):,\n\s])/$qqq$sp{$1}$qqq$2/g;
   } else {
      $line =~ s/[\'\"]*(\s*)\b($abbr)(\s*)[\'\"]*([ \t]*)([\[):,\n\s])/$qqq$1$sp{$2}$qqq$3$4$5/g;
   }
}
print $line;
close(TREE);








# Zum erinnern:
#printsub(\$a \$b);
#sub printsub{
#    ($a,$b) = _@;
#    return $b;
#}

sub printusage {
   print "\n$PACKAGENAME (version $PACKAGEVERSION)\n";
   print "\nUSAGE: taxnameconvert.pl [-f#] [-t#] [-Q#] [-b] <table> <tree> [<out>]\n\n";
   print "   Convert species names within Newick format treefiles.\n\nOPTIONS:\n\n";
   print "   -f<from>   - source column number for conversion [1]\n";
   print "   -t<to>     - target column number for conversion [2]\n";
   print "   -Q<quote>  - quote type to use around names: 1=', 2=\", 0=none [0]\n";
   print "   -b         - keep blanks in search and replace strings [off]\n";
   print "                (e.g. to keep name lengths in alignments)\n";
   print "   -h         - this help text\n";
   print "   <table>    - conversion table filename\n";
   print "   <tree>     - input tree filename\n";
   print "   <out>      - output tree filename (uses stdout if ommitted)\n";
   print "\n";
   print "NOTE: The program does not check whether a taxon name is prefix/postfix/infix\n";
   print "      of another, i.e., it is contained within another name.\n";
   print "\n";
}

sub printparams{
   print STDERR "$PACKAGENAME (version $PACKAGEVERSION)\n\n";
   print STDERR "   Parameters:\n";
   print STDERR "   command         : $progname\n";
   print STDERR "   arguments       : '@ARGV' ($numargs)\n";
   print STDERR "   Conversion Table: $dbfile\n";
   print STDERR "      from column  : ".($fromtab + 1)."\n";
   print STDERR "      to column    : ".($totab + 1)."\n";
   if ($quote == 0) {
      print STDERR "   Quotation type  : none ($quote)\n";
   } elsif ($quote == 1) {
      print STDERR "   Quotation type  : ".$qqq."single".$qqq." ($quote)\n";
   } else {
      print STDERR "   Quotation type  : ".$qqq."double".$qqq." ($quote)\n";
   }
   print STDERR "   Input Treefile  : $trfile\n";
   if ($redirout) {
	   print STDERR "   Output Treefile : $outfile\n\n";
   } else {
	   print STDERR "   Output Treefile : STDOUT\n\n";
   }
}
