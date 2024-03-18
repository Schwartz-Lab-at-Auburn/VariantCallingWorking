#!/bin/bash
#SBATCH -J sm
#SBATCH -o out
#SBATCH -e err
#SBATCH -p general
#SBATCH -n 1
#SBATCH -t 9000
#SBATCH --mem=10000

#CONDA_BASE=$(conda info --base)
#source $CONDA_BASE/etc/profile.d/conda.sh
#conda activate snakemake
snakemake --snakefile workflow/Snakefile --profile ./profiles/slurm
