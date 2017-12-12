### script to design hairpin primers

source("http://bioconductor.org/biocLite.R") # required package
biocLite("Biostrings")
require("Biostrings")

primers <- readBStringSet(file.choose(), format="fasta") # input is a primer list
hairpin_length <- 13 # bp of complimentary region
adapter_seq <- DNAStringSet("GGGGGGGGG") # paste the sequence that you want

hairpin_primer <- function(dna){ 
  dna <- DNAStringSet(dna) # primer sequence
  hairpin <- unlist(reverseComplement(dna))[1:hairpin_length] # hairpin 
  out_primer <- xscat(hairpin, adapter_seq, dna) # all concatenated
}

primer_list <- hairpin_primer(primers)
names(primer_list) <- names(primers)
writeXStringSet(primer_list, 'test_out.fa') # output to new fasta
