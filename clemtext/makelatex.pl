#!/usr/bin/perl
# 31/3/04 - little.mouth@soon.com - GPL
# Perl script to generate LaTeX files from VulSearch Latin source files
# Requirements: perl, sed
# 
# Usage: perl makelatex.pl
# 
# Output: 
# files latex/ABBREV.tex for each abbreviation ABBREV of a book of the Bible
# 
# Background and documentation at http://vulsearch.sf.net/plain.html
# The main bulk of the conversion is done using makelatex.sed: this script
# just adds a header, and deals with a couple of eccentricities (see inline
# comments passim).

$source='source'; #source directory
$ext='lat'; #file extension
$tex='latex'; #LaTeX output directory

#initialize our hash of book names
@bib =
(
  'Gn', 'Ex', 'Lv', 'Nm', 'Dt', 'Jos', 'Jdc', 'Rt', '1Rg', '2Rg', '3Rg', '4Rg', '1Par', '2Par',
  'Esr', 'Neh', 'Tob', 'Jdt', 'Est', 'Job', 'Ps', 'Pr', 'Ecl', 'Ct', 'Sap', 'Sir', 'Is', 'Jr',
  'Lam', 'Bar', 'Ez', 'Dn', 'Os', 'Joel', 'Am', 'Abd', 'Jon', 'Mch', 'Nah', 'Hab', 'Soph', 'Agg',
  'Zach', 'Mal', '1Mcc', '2Mcc', 'Mt', 'Mc', 'Lc', 'Jo', 'Act', 'Rom', '1Cor', '2Cor', 'Gal',
  'Eph', 'Phlp', 'Col', '1Thes', '2Thes', '1Tim', '2Tim', 'Tit', 'Phlm', 'Hbr', 'Jac', '1Ptr',
  '2Ptr', '1Jo', '2Jo', '3Jo', 'Jud', 'Apc'
);

#for special characters in the book names
sub cleanup
{
  my ($s)=@_;
  $s =~ s/\xe6(\s)/\\ae\\\1/g;
  $s =~ s/\xe6/\\ae /g;
  $s =~ s/\xeb/\\"e/g;
  return $s;
}

foreach my $book (@bib)
{
  open(DATA, "sed -n -e \"/^$book\\//p\" $source/data.txt |")    || die "can't fork sed";
  ($_,$long,$short,$create,$proof)=split /\//, <DATA>;
  close DATA;
  $long=cleanup($long);
  $short=cleanup($short);
  chomp($proof);

  open(OUT,"> $tex/$book.tex") || die "can't open $tex/$book.tex";

  #print head
  if ($book eq '3Jo')
  {
    print OUT "\\newpage\n";
  } # in two-column layout, 2Jo and 3Jo can go on the same page; all other
  else # books start on a fresh page
  {
    print OUT "\\clearpage\n";
  }
  print OUT "{\\centering \\section*{$long}}\\thispagestyle{empty}\n";
  print OUT "\\addcontentsline{toc}{subsection}{", ucfirst($short), "}\n";
  print OUT "\\fancyhead[C]{\\textsc{$short}}\n\n";

  #print main body of the book, mostly converted by a sed script
  open(IN, "sed -f makelatex.sed $source/$book.$ext |")    || die "can't fork sed";
  $x=<IN>;
  chomp($x);
  if ($book eq 'Abd' || $book eq 'Phlm' || $book eq '2Jo' || $book eq '3Jo' || $book eq 'Jud')
  {
    $x=~s/\\Needspace\{2.5\\baselineskip\}\\versal\{1\}~/\\noindent /;
  } #Abd, Phlm, {2,3}Jo, Jud have only one chapter
  print OUT "$x\n";

  print OUT "$x" while ($x=<IN>);
  close(IN);

  close(OUT);
}
