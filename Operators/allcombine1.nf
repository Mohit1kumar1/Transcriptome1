nextflow.enable.dsl=2

params.output_file = 'summary1.txt'
include{STAR_LOG_FILES} from "./star.nf"
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
    path (params.output_file)

    script:
    """
    Rscript /homes/mkumar/practice/src/summary.r ${start_values} ${star_grc_log} ${star_chm_log} ${bowtie_grc_log} ${bowtie_chm_log} ${vg_grc_log} ${vg_chm_log} ${sortmerna_log} ${params.output_file}
    """
}

 workflow{
    LOG_FILES_SUMMARY (
        Channel.fromPath("/homes/mkumar/practice/report_test_files/startvalue.rds"),
        Channel.fromPath("/homes/mkumar/practice/report_test_files/bowtiedict.txt.rds"),
        Channel.fromPath("/homes/mkumar/practice/report_test_files/bowtiedict.txt_chm.rds"),
        Channel.fromPath("/homes/mkumar/practice/report_test_files/star1.txt.rds"),
        Channel.fromPath("/homes/mkumar/practice/report_test_files/star1.txt.chm.rds"),
        Channel.fromPath("/homes/mkumar/practice/report_test_files/VG.txt.rds"),
        Channel.fromPath("/homes/mkumar/practice/report_test_files/VG.txt_chm.rds"),
        Channel.fromPath("/homes/mkumar/practice/report_test_files/sortmerna.txt.rds")
    )
}

