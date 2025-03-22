#!/usr/bin/env nextflow

process sayHello {
  input: 
    val x
  output:
    stdout
  script:
    """
    echo 'words'
    echo '$x'
    """
}

workflow {
  if (!params.words_txt) {
    exit 1, "Missing input words.txt"
  }

  // Log the input parameters
  log.info "Input words: ${params.words_txt}"

  Channel.fromPath(params.words_txt) 
    | sayHello 
	| collectFile( name: "words.txt", keepHeader: true, sort: true )
}
