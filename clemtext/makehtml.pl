#!/usr/bin/perl
# 12/1/04 - little.mouth@soon.com - GPL
# Perl script to generate valid XHTML 1.0 from VulSearch Latin source files
# Requirements: perl, sed
# 
# Usage: perl makehtml.pl
# 
# Output: 
# files html/ABBREV.html for each abbreviation ABBREV of a book of the Bible
# 
# Background and documentation at http://vulsearch.sf.net/plain.html
# The main bulk of the conversion is done using makehtml.sed: this script
# just adds a header and footer, and deals with a couple of eccentricities
# (see inline comments passim).

$source='source'; #source directory
$ext='lat'; #file extension
$html='html'; #html output directory

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
  $s =~ s/\xe6/\&aelig;/g;
  $s =~ s/\xeb/\&euml;/g;
  $s =~ s/\x9c/\&oelig;/g;
  return $s;
}

($dd,$mm,$yy)=(localtime(time))[3,4,5];
$yy=sprintf("%02d",$yy % 100);
$mm++;

foreach my $book (@bib)
{
  open(DATA, "sed -n -e \"/^$book\\//p\" $source/data.txt |")    || die "can't fork sed";
  ($_,$long,$short,$create,$proof)=split /\//, <DATA>;
  close DATA;
  $long=cleanup($long);
  $short=cleanup($short);
  chomp($proof);

  open(OUT,"> $html/$book.html") || die "can't open $html/$book.html";

  #print head
  print OUT '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">', "\n";
  print OUT '<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="la">', "\n";
  print OUT '<head>', "\n";
  print OUT "<title>$short - Vulgata Clementina</title>", "\n";
  print OUT '<link rel="stylesheet" type="text/css" href="../newstyle.css" />', "\n";
  print OUT '<link rel="stylesheet" type="text/css" href="vulgata.css" />', "\n";
  print OUT '<link rel="icon" type="image/png" href="../favicon.png" />', "\n";
  print OUT '<link rel="alternate" type="application/rss+xml" title="Clementine text updates" href="../clemtext.rss" />', "\n";
  print OUT '<link rel="start" title="Clementine text project" href="http://vulsearch.sf.net/gettext.html" />', "\n";
  print OUT '<meta name="author" content="little dot mouth at soon dot com" />', "\n";
  print OUT '<meta name="keywords" content="vulgate bible jerome clementine catholic tridentine traditional vulsearch" />', "\n";
  print OUT '<meta name="description" content="The Clementine Vulgate text of ', "$short", ' (part of the Clementine Vulgate project, http://vulsearch.sf.net/gettext.html)." />', "\n";
  print OUT '</head>', "\n";
  print OUT '', "\n";
  print OUT '<body>', "\n";
  print OUT '<div id="root">', "\n";
  print OUT '<div id="masthead">', "\n";
  print OUT '<a href="http://vulsearch.sf.net/gettext.html"><img src="../vs.png" alt="Clementine text project" /></a>', "\n";
  print OUT '<h1>VulSearch &amp; the Clementine Vulgate project</h1>', "\n";
  print OUT '</div>', "\n";
  print OUT '<div id="navbar">', "\n";
  print OUT '<h2>Contents</h2>', "\n";
  print OUT '<ul>', "\n";
  print OUT '<li>', "\n";
  print OUT '<a href="http://vulsearch.sf.net/gettext.html">Home page</a>', "\n";
  print OUT '</li>', "\n";
  print OUT '<li>', "\n";
  print OUT '<a href="http://vulsearch.sf.net/contact.html">Contact me</a>', "\n";
  print OUT '</li>', "\n";
  print OUT '<li>', "\n";
  print OUT '<a href="http://vulsearch.sf.net/cgi-bin/vulsearch">Search the text online</a>', "\n";
  print OUT '</li>', "\n";
  print OUT '<li>', "\n";
  print OUT '<a href="index.html">Vulgata Clementina</a>', "\n";
  print OUT '<ul>', "\n";
  print OUT '<li><a href="Gn.html">Genesis</a></li>', "\n";
  print OUT '<li><a href="Ex.html">Exodus</a></li>', "\n";
  print OUT '<li><a href="Lv.html">Leviticus</a></li>', "\n";
  print OUT '<li><a href="Nm.html">Numeri</a></li>', "\n";
  print OUT '<li><a href="Dt.html">Deuteronomium</a></li>', "\n";
  print OUT '<li><a href="Jos.html">Josue</a></li>', "\n";
  print OUT '<li><a href="Jdc.html">Judicum</a></li>', "\n";
  print OUT '<li><a href="Rt.html">Ruth</a></li>', "\n";
  print OUT '<li><a href="1Rg.html">Regum I</a></li>', "\n";
  print OUT '<li><a href="2Rg.html">Regum II</a></li>', "\n";
  print OUT '<li><a href="3Rg.html">Regum III</a></li>', "\n";
  print OUT '<li><a href="4Rg.html">Regum IV</a></li>', "\n";
  print OUT '<li><a href="1Par.html">Paralipomenon I</a></li>', "\n";
  print OUT '<li><a href="2Par.html">Paralipomenon II</a></li>', "\n";
  print OUT '<li><a href="Esr.html">Esdr&aelig;</a></li>', "\n";
  print OUT '<li><a href="Neh.html">Nehemi&aelig;</a></li>', "\n";
  print OUT '<li><a href="Tob.html">Tobi&aelig;</a></li>', "\n";
  print OUT '<li><a href="Jdt.html">Judith</a></li>', "\n";
  print OUT '<li><a href="Est.html">Esther</a></li>', "\n";
  print OUT '<li><a href="Job.html">Job</a></li>', "\n";
  print OUT '<li><a href="Ps.html">Psalmi</a></li>', "\n";
  print OUT '<li><a href="Pr.html">Proverbia</a></li>', "\n";
  print OUT '<li><a href="Ecl.html">Ecclesiastes</a></li>', "\n";
  print OUT '<li><a href="Ct.html">Canticum Canticorum</a></li>', "\n";
  print OUT '<li><a href="Sap.html">Sapientia</a></li>', "\n";
  print OUT '<li><a href="Sir.html">Ecclesiasticus</a></li>', "\n";
  print OUT '<li><a href="Is.html">Isaias</a></li>', "\n";
  print OUT '<li><a href="Jr.html">Jeremias</a></li>', "\n";
  print OUT '<li><a href="Lam.html">Lamentationes</a></li>', "\n";
  print OUT '<li><a href="Bar.html">Baruch</a></li>', "\n";
  print OUT '<li><a href="Ez.html">Ezechiel</a></li>', "\n";
  print OUT '<li><a href="Dn.html">Daniel</a></li>', "\n";
  print OUT '<li><a href="Os.html">Osee</a></li>', "\n";
  print OUT '<li><a href="Joel.html">Jo&euml;l</a></li>', "\n";
  print OUT '<li><a href="Am.html">Amos</a></li>', "\n";
  print OUT '<li><a href="Abd.html">Abdias</a></li>', "\n";
  print OUT '<li><a href="Jon.html">Jonas</a></li>', "\n";
  print OUT '<li><a href="Mch.html">Mich&aelig;a</a></li>', "\n";
  print OUT '<li><a href="Nah.html">Nahum</a></li>', "\n";
  print OUT '<li><a href="Hab.html">Habacuc</a></li>', "\n";
  print OUT '<li><a href="Soph.html">Sophonias</a></li>', "\n";
  print OUT '<li><a href="Agg.html">Agg&aelig;us</a></li>', "\n";
  print OUT '<li><a href="Zach.html">Zacharias</a></li>', "\n";
  print OUT '<li><a href="Mal.html">Malachias</a></li>', "\n";
  print OUT '<li><a href="1Mcc.html">Machab&aelig;orum I</a></li>', "\n";
  print OUT '<li><a href="2Mcc.html">Machab&aelig;orum II</a></li>', "\n";
  print OUT '<li><a href="Mt.html">Matth&aelig;us</a></li>', "\n";
  print OUT '<li><a href="Mc.html">Marcus</a></li>', "\n";
  print OUT '<li><a href="Lc.html">Lucas</a></li>', "\n";
  print OUT '<li><a href="Jo.html">Joannes</a></li>', "\n";
  print OUT '<li><a href="Act.html">Actus Apostolorum</a></li>', "\n";
  print OUT '<li><a href="Rom.html">ad Romanos</a></li>', "\n";
  print OUT '<li><a href="1Cor.html">ad Corinthios I</a></li>', "\n";
  print OUT '<li><a href="2Cor.html">ad Corinthios II</a></li>', "\n";
  print OUT '<li><a href="Gal.html">ad Galatas</a></li>', "\n";
  print OUT '<li><a href="Eph.html">ad Ephesios</a></li>', "\n";
  print OUT '<li><a href="Phlp.html">ad Philippenses</a></li>', "\n";
  print OUT '<li><a href="Col.html">ad Colossenses</a></li>', "\n";
  print OUT '<li><a href="1Thes.html">ad Thessalonicenses I</a></li>', "\n";
  print OUT '<li><a href="2Thes.html">ad Thessalonicenses II</a></li>', "\n";
  print OUT '<li><a href="1Tim.html">ad Timotheum I</a></li>', "\n";
  print OUT '<li><a href="2Tim.html">ad Timotheum II</a></li>', "\n";
  print OUT '<li><a href="Tit.html">ad Titum</a></li>', "\n";
  print OUT '<li><a href="Phlm.html">ad Philemonem</a></li>', "\n";
  print OUT '<li><a href="Hbr.html">ad Hebr&aelig;os</a></li>', "\n";
  print OUT '<li><a href="Jac.html">Jacobi</a></li>', "\n";
  print OUT '<li><a href="1Ptr.html">Petri I</a></li>', "\n";
  print OUT '<li><a href="2Ptr.html">Petri II</a></li>', "\n";
  print OUT '<li><a href="1Jo.html">Joannis I</a></li>', "\n";
  print OUT '<li><a href="2Jo.html">Joannis II</a></li>', "\n";
  print OUT '<li><a href="3Jo.html">Joannis III</a></li>', "\n";
  print OUT '<li><a href="Jud.html">Jud&aelig;</a></li>', "\n";
  print OUT '<li><a href="Apc.html">Apocalypsis</a></li>', "\n";
  print OUT '</ul>', "\n";
  print OUT '</li>', "\n";
  print OUT '</ul>', "\n";
  print OUT '</div>', "\n";
  print OUT '<div id="content">', "\n";
  print OUT "<h2>$long</h2>\n";
  print OUT '<div xml:lang="en">', "\n";
  print OUT '<h3>About this text</h3>', "\n";
  print OUT "<p>This document was generated on the $dd/$mm/$yy and is part of the\n";
  print OUT '<a href="http://vulsearch.sf.net/gettext.html">Clementine Vulgate project</a>.', "\n";
  print OUT "The text was created by $create and has been proof-read by $proof.\n";
  print OUT 'If you find an error in this text, please report it to little.mouth@soon.com.</p>', "\n";
  print OUT '</div>', "\n";
  print OUT '<div id="text">', "\n";
  print OUT "<h3>$long</h3>", "\n";


  #print main body of the book, mostly converted by a sed script
  open(IN, "sed -f makehtml.sed $source/$book.$ext | tr -d '\r' |")    || die "can't fork sed";
  $x=<IN>;
  chomp($x);
  if ($book eq 'Abd' || $book eq 'Phlm' || $book eq '2Jo' || $book eq '3Jo' || $book eq 'Jud')
  {
    $x=~s/<span class="chapter-num">1<\/span> //;
  } #Abd, Phlm, {2,3}Jo, Jud have only one chapter
  print OUT "$x\n";

  while ($x=<IN>)
  {
    print OUT "$x";
  }
  close(IN);

  #print foot
  print OUT '<p lang="en" style="margin-top: -1em; text-align: center;">', "\n";
  print OUT '<a href="http://validator.w3.org/check?uri=referer"><img
  style="border: 0;"', "\n";
  print OUT '      src="valid-xhtml10.png" alt="Valid XHTML 1.0!" height="31"', "\n";
  print OUT '      width="88" /></a>', "\n";
  print OUT '  <a href="http://jigsaw.w3.org/css-validator/check/referer"><img
  style="border: 0;"', "\n";
  print OUT '      src="vcss.png" alt="Valid CSS!" height="31" width="88" /></a>', "\n";
  print OUT '</p>', "\n";
  print OUT '</div>', "\n";
  print OUT '</div>', "\n";
  print OUT '</div>', "\n";
  print OUT '</body>', "\n";
  print OUT '</html>', "\n";

  close(OUT);
  $c="s/^<li><a href=\\(.\\)$book.html\\(.\\)>\\(.*\\)<\\/a><\\/li>/<li><span class=\\1active\\2>\\3<\\/span><\\/li>/";
  `sed -i -e "$c" $html/$book.html`;
}

