/*
channel.of('alpha', 'beta', 'gamma')
     .collectFile(name: 'sample.txt', newLine: true)
     .subscribe {
        println "Entries are saved to file: $it"
        println "File content is: ${it.text}"
     }

channel.of('abba','dabba','jhabba')
     .collectFile { item ->
         ["${item[0]}.txt", item + '\n']
     }
     .subscribe {
        println "File '${it.name}' contains:"
        println it.text
     }
*/

Channel
    .fromPath('/homes/mkumar/practice/data/M_D_KF_010_subset_T1.unmapped_1.fastq.gz')
    .splitFasta( record: [id: true, sequence: true] )
    .collectFile( name: 'result.fa', sort: { it.size() } ) {
        it.sequence
    }
    .view { it.text }