#!/usr/bin/sed -f
# 10/1/05 - little.mouth@soon.com - GPL
# sed script to generate LaTeX markup from from VulSearch Latin source files. An
# accompanying Perl script, makelatex.pl, adds headers and footers to make a
# LaTeX file suitable for includsion in latex/{vulgate,twocolumn}.tex
# To convert the resulting source files to PDF, you can use the accompanying
# batch files makepdf-vulgate.bat and makepdf-twocolumn.bat
# which are also valid as bash scripts.
#
# Requirements: sed
# 
# Usage: sed -f makelatex.sed SOURCEFILE where SOURCEFILE is the Latin source
# file to convert
# 
# Output: source file with appropriate LaTeX markup added
# 
# Background and documentation at http://vulsearch.sf.net/plain.html including a
# description of the source format (see also comments below).


#first take care of \
s/\\/@/g

#now do special characters
s/ë/\\"e/g
s/æ$/\\ae\\/
s/æ /\\ae\\ /g
s/æ/\\ae /g
s/œ /\\oe\\ /g
s/œ/\\oe /g
s/Æ/\\AE /g
s/ \([:;!?]\)/~\1/g
s/\\~/~/g


#===
#verse numbering
#first move [ at start of verse text to start of line
s/\([1-9][0-9:]* \)\[/[\1/

#now do chapter numbers
s/\(\[*\)\([0-9][0-9]*\):1 /\\Needspace{2.5\\baselineskip}\\versal{\2}~\1/

#finally do the other verses
s/\(\[*\)\([0-9][0-9]*\):\([0-9][0-9]*\) /\1${}^{\3}$~/
#===


#do < >
s/</\\textsc{/g
s/>/.} /g

#special arrangments for Lam and Sir, which have prologues
s/\(\\Needspace{2.5\\baselineskip}\\versal{1}~\)\\textsc{Prologus.}\(.*\)\(\[\)/\\begin{center}\\textsc{Prologus}\\end{center}\\vspace{-6pt}\2@\1\3/

#If a chapter starts with verse, we need to move it up to compensate for top
#padding in the flushleft environment. If the chapter number is two digits
#long, we need extra horizontal space as well, to avoid the versal overlapping
#with the first line of verse.
s/\(\\versal{[1-9]}\)~\[/\1[\\vspace{-19pt}/
s=\(\\versal{[1-9][0-9][0-9]*}\)~\[\([^/]*/\)=\1[\\vspace{-19pt}\\hspace{6pt}\2\\hspace{6pt}=

#we also need some extra vertical elbow room if poetry begins in the first line of
#a chapter
s/\(\\versal{[0-9]*}~[^[].*\)\[/\1[\\vspace{6pt}/
s/\[\(\${}^{2}\$\)/[\\vspace{6pt}\1/

#now do [ ] /
s/\[/\\begin{flushleft}\\begin{verse}/g
s/\]@*/\\end{verse}\\end{flushleft}@/g
s/\//\\\\/g
s/^\(\\Needspace{2.5\\baselineskip}\\versal{1}\\begin{flushleft}\\begin{verse}\\vspace{-1\)9pt}/\11pt}/
#(I have no idea why the previous adjustment should be needed...)

#finally do the orginal \ (which have become @)
s/@/\
\
/g
