#!/bin/bash -ue
file_list=M_D_KF_010_subset_T1.Log.final.out M_D_PF_009a_subset_T1.Log.final.out M_D_PF_011a_subset_T1.Log.final.out

echo "File list: $file_list"

Rscript /homes/mkumar/practice/src/dict.r $file_list output.txt
