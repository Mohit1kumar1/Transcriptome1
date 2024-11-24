nextflow.enable.dsl=2

params.output_file = 'sortmerna.txt'
include{PROCESS_LOG_FILES} from "./combine.nf"
process LOG_FILES_SUMMARY {
    input:
    path start_values
    path star_grc_log
    path star_chm_log
    path bowtie_grc_log
    path bowtie_chm_log
    path vg_grc_log
    path vg_chm_log
    path sortmerna_log

    output:
    path(params.output_file)

    script:
    """
    Rscript /homes/mkumar/practice/src/summary.r ${start_values} ${star_grc_log} ${star_chm_log} ${bowtie_grc_log} ${bowtie_chm_log} ${vg_grc_log} ${vg_chm_log} ${sortmerna_log} ${params.output_file}
    """
}

 workflow{
    sortmerna_log_files = Channel.of(["id":"M_D_KF_010"])
.combine(Channel.fromPath("/homes/mkumar/practice/sortmerna_example_files/M_D_KF_010_subset_T1.sortmerna.log"))
.concat(Channel.of(["id":"M_D_PF_009a"])
 .combine(Channel.fromPath("/homes/mkumar/practice/sortmerna_example_files/M_D_PF_009a_subset_T1.sortmerna.log")))
.concat(Channel.of(["id":"M_D_PF_011a"])
 .combine(Channel.fromPath("/homes/mkumar/practice/sortmerna_example_files/M_D_PF_011a_subset_T1.sortmerna.log")))

//SAMTOOLS_VIEW(bowtie_log_files).out.log_files.flatten().branch ...

sortmerna_log_files
    .flatten()// 
    .branch {
        ids: it instanceof Map
        log_files: it instanceof Path
        }
    .set { result }


result.ids.map{it.id}.view { "$it is small" }
result.log_files.view { "$it is large" }

SORTMERNA_LOG_FILES(result.ids.map{it.id}.collect(), result.log_files.collect())
//PROCESS_LOG_FILES(bowtie_log_files.collect())
}

