#!/bin/bash -ue
mkdir -p /homes/mkumar/practice/output_dir

file_list=$(echo M_D_KF_010_subset_T1.Log.final.out M_D_PF_009a_subset_T1.Log.final.out M_D_PF_011a_subset_T1.Log.final.out)

 Rscript /homes/mkumar/practice/src/dict.r $file_list /homes/mkumar/practice/output_dir/output123.txt