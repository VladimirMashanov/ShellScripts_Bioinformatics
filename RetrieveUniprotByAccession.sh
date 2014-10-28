#!/bin/bash

#This script retrieves the fasta sequences from the UniProt database if you provide an input file
#with accession numbers, one number per line

##USAGE##
# RetrieveUniprotByAccession.sh InputFile

#Checking if the right number of arguments is used
if [ $# -ne 1 ] #if the number of arguments is not equal to 1
	then
	echo "Usage: $0 InputFile"; #Explain the usage syntax, where $0 is the name of the script
	exit 1; #Exit from the script with an non-zero status, indicating unsuccessful completion
fi

# Checking if the input file exists:
if [ ! -f $1 ] # if the input file (argument $1) does not exist
then
	echo "File $1 does NOT exist"; #notify the user about the error
	exit 1; #exit with an non-zero status (=failure)
fi

while read line # Reading the input file $1 line-by-line
do
	wget http://www.uniprot.org/uniprot/$line.fasta #Retrieving the sequence form the UniProt website as described in http://www.uniprot.org/help/programmatic_access
	status=$? #Store the exit status of wget
	if [ $status -eq 0 ] #checking if wget was a success (zero) or a failure (nonzero)
	then
		echo -e "\e[32m The sequence $line.fasta has been saved in the current working directory \e[0m \n" #echo output in green: \e[ begins the escape sequence, 32 is the code for green, 0 is the code for regular characters, m is the end of the espace sequence
	else
		echo -e "\e[31m The sequence $line.fasta has not been found in the database \e[0m \n" #echo output in red: 31 is the code for red
fi
done < $1
