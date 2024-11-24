/*
 * to add default parameter instead of writing every time in the command line.
 */
params.output_file = 'output1.txt'

/*
 * use echo to print 'hallo welt' to standard out
 */

process sayhallo1 {

    input:
        val greeting
    
    output:
        path "${greeting}-${params.output_file}"
    
    """
    echo '$greeting' > '$greeting-$params.output_file'
    """
}

process converttoUpper{

    input:
       path input_file

    output:
       path "UPPER-${input_file}"
    
    """
    cat $input_file |tr '[a-z]' '[A-Z]' > UPPER-$input_file
    """
}

workflow {

    // creating a channel for inputs
    greeting_ch = channel.fromPath(params.input_file).splitText(){it.trim()}

    // emit a greeting
    sayhallo1(greeting_ch)

    //convert the greeting to uppercase
    converttoUpper(sayhallo1.out)
}

