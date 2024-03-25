#!/bin/bash
# This script generates the config table necessary for the snpArcher pipeline. I provided a sample table in github, so you only need to run this if you want to make your own table.

# Set variables
MyID=""		ex: lgh0053                                                                 
DataDir="/scratch/$MyID/terrapin_data/clean"
Samples=$(ls "$DataDir")

# Set path for final output config table. This should be somewhere snpArcher can reach, and you'll need to point to it in your snparcher/config/config.yaml file. 
# Ideally the final output will be located in snparcher/config/samples.csv
CONFIG="/home/$MyID/Terrapin_Project/VCF_generation/analysis/snparcher/config_table/samples.csv"

#mkdir -p /home/$MyID/Terrapin_Project/VCF_generation/analysis/snparcher/config_table


# Set path for reference local ref genome. Note: for this terrapin dataset, there are two reference files that downloaded from NCBI. The only difference is in the fasta headers.
RefPath=""

# Ref genome accession from NCBI. By default, snparcher uses the accession to download the reference, but I've had better results downloading locally. For the terrapin data, you should be able to read and execute in my reference directory (given above).
RefAcc=""    ex:SAMN31394215                                                                  

# Write header to output CSV file
echo "BioSample,Run,LibraryName,refGenome,refPath,fq1,fq2" > "$CONFIG"

# Loop through each sample. You may need to customize this loop for your data.
for i in $Samples; do

	#Subset all runs per sample. It's important to note that each sample will have a run1 and run2 column, so you essentially need to ignore the _2.fq.gz for right now when you're setting up rows.    
	SampleRuns=$(ls $DataDir/$i | grep -E "_1\.fq\.gz$" | awk -F "_1.fq.gz" '{print $1}' | uniq)

	#Make a row for each sample for the table
	for c in $SampleRuns; do
		# Set up BioSample name; "The name of the sample. This will be the sample name in the final VCF"
		BioSample="Sample$i"

		#Set run ID. This is usually the lane number but also must be unique.
		Lane=$(echo "$c" | awk -F "_" '{print $2}')		

		#Also extract 
		ID=$(echo "$c" | awk -F '-' '{print $2}' | cut -d '_' -f 1)

		# LibraryID for sample, this can be the same or different than BioSample. I'm going to use the name, ignoring the read number.
		LibraryName="$c"

		# Set paths to fasta files
		fq1="$DataDir/$i/${c}_1.fq.gz"
		fq2="$DataDir/$i/${c}_2.fq.gz"

		# Append information to output CSV file
		echo "$BioSample,${Lane}_${ID},$LibraryName,$RefAcc,$RefPath,$fq1,$fq2" >> "$CONFIG"
	done
done

