### script to design hairpin primers

source("http://bioconductor.org/biocLite.R") # required package
biocLite("Biostrings")
require("Biostrings")

primers <- readDNAStringSet(file.choose(), format="fasta") # input is a primer list
hairpin_length <- 13 # bp of complimentary region
#adapter_seq <- DNAString("GTGACTGGAGTTCAGACGTGT") # adapters
adapter_seq <- DNAString("ACACTCTTTCCCTACACGACGCTCTT")

hairpin_primer <- function(dna){ 
  hairpin <- unlist(reverseComplement(dna))[1:hairpin_length] # hairpin 
  out_primer <- xscat(hairpin, adapter_seq, dna) # all concatenated
}

primer_list <- lapply(primers, hairpin_primer)
names(primer_list) <- names(primers)
writeXStringSet(DNAStringSet(primer_list), 'hairpin.fa',append=T) # output to new fasta
