#!/bin/sh
cd latex
pdflatex twocolumn.tex
pdflatex twocolumn.tex
cd ..
echo "PDF file twocolumn.pdf produced in directory latex"
