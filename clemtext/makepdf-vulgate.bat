#!/bin/sh
cd latex
pdflatex vulgate.tex
pdflatex vulgate.tex
cd ..
echo "PDF file vulgate.pdf produced in directory latex"
