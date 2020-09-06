#!/bin/bash
IFS='.'
OLD_T=(Gn Ex Lv Nm Dt Jos Jdc Rt 1Rg 2Rg 3Rg 4Rg 1Par 2Par Esr Neh Tob Jdt Est 1Mcc 2Mcc Job Ps Pr Ecl Ct Sap Sir Is Jr Lam Bar Ez Dn Os Joel Am Abd Jon Mch Nah Hab Soph Agg Zach Mal)
NEW_T=(Mt Mc Lc Jo Act Rom 1Cor 2Cor Gal Eph Phlp Col 1Thes 2Thes 1Tim 2Tim Tit Phlm Hbr Jac 1Ptr 2Ptr 1Jo 2Jo 3Jo Jud Apc)
TESTMT=null
BOOK=null
for file in ../src/*.lat; do
    read -a fileparts <<< "$file"
    if [[ "${OLD_T[*]}" =~ "\${fileparts[0]}\b" ]] then
        TESTMT = 0
    elif [[ "${NEW_T[*]}" =~ "\${fileparts[0]}\b" ]] then
        TESTMT = 1
    fi

    for i in "${!my_array[@]}"; do
        if [[ "${my_array[$i]}" = "${fileparts[0]}" ]]; then
            BOOK = ${i} + 1;
            break;
        fi
    done

    sed -ir "s/^([0-9]{1,3}):([0-9]{1,3})/${TESTMT}|${BOOK}|$1|$2/g" ${file}
done
