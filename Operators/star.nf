
nextflow.enable.dsl=2

params.output_file = 'star1.txt'

process STAR_LOG_FILES {
    input:
    val ids
    path log_files

    output:
    path params.output_file

    script:
    """
    echo "IDs: ${ids.join(" ")}"
    echo "Log files: ${log_files.join(" ")}"
    Rscript /homes/mkumar/practice/src/dict.r ${ids.join(" ")} ${log_files.join(" ")} ${params.output_file}
    
    """
}


workflow {
    star_log_files =  Channel.of(["id":"M_D_KF_010"]).combine(Channel
        .fromPath("/homes/mkumar/practice/test_files/M_D_KF_010_subset_T1.Log.final.out"))
             .concat(Channel.of(["id":"M_D_PF_009a"]).combine(Channel.fromPath("/homes/mkumar/practice/test_files/M_D_PF_009a_subset_T1.Log.final.out")))

.concat(Channel.of(["id":"M_D_PF_011a"]).combine(Channel.fromPath("/homes/mkumar/practice/test_files/M_D_PF_011a_subset_T1.Log.final.out")))

star_log_files
    .flatten()//
    .branch {
        ids: it instanceof Map
        log_files: it instanceof Path
    }
    .set{result}

result.ids.map{it.id}.view{"$it is id"}
result.log_files.view{"$it is path"}

STAR_LOG_FILES(result.ids.map{it.id}.collect(), result.log_files.collect())
}


