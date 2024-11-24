#!/bin/bash -ue
mkdir -p null

file_list=$(echo M_D_KF_010_subset_T1.Log.final.out M_D_PF_009a_subset_T1.Log.final.out M_D_PF_011a_subset_T1.Log.final.out | tr ' ' ' ')

Rscript /homes/mkumar/practice/src/dict.r $file_list null/output123.txt
