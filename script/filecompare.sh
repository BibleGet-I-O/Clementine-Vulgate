#!/bin/bash
IFS='.'
OLD_T=(Gn Ex Lv Nm Dt Jos Jdc Rt 1Rg 2Rg 3Rg 4Rg 1Par 2Par Esr Neh Tob Jdt Est 1Mcc 2Mcc Job Ps Pr Ecl Ct Sap Sir Is Jr Lam Bar Ez Dn Os Joel Am Abd Jon Mch Nah Hab Soph Agg Zach Mal)
NEW_T=(Mt Mc Lc Jo Act Rom 1Cor 2Cor Gal Eph Phlp Col 1Thes 2Thes 1Tim 2Tim Tit Phlm Hbr Jac 1Ptr 2Ptr 1Jo 2Jo 3Jo Jud Apc)

echo "Checking Old Testament files..."
for file in ${OLD_T[@]}; do
	if [[ -f "../src/utf8/${file}.lat" ]]; then
		echo "File ${file}.lat exists"
	else
		echo "File ${file}.lat does not exist!!!"
	fi
done

echo ""
echo "Checking New Testament files..."
for file in ${NEW_T[@]}; do
        if [[ -f "../src/utf8/${file}.lat" ]]; then
                echo "File ${file}.lat exists"
        else
                echo "File ${file}.lat does not exist!!!"
        fi
done

