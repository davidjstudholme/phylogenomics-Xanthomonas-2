#!/bin/bash
#SBATCH --export=ALL # export all environment variables to the batch job
#SBATCH -D . # set working directory to .
#SBATCH -p bioseq # submit to the parallel queue (pq)mrc queue(mrcq)serial queue(sq)
#SBATCH --time=168:00:00 # maximum walltime for the job
#SBATCH -A research_project-bioproduction  # research project to submit under
#SBATCH --nodes=1 # specify number of nodesq pq
#SBATCH --ntasks-per-node=7 # specify number of processors per node
#SBATCH --mail-type=END # send email at job completion
#SBATCH --mail-user=j.w.harrison@exeter.ac.uk # email address

. "/gpfs/ts0/projects/Research_Project-BioSandbox/miniconda3/etc/profile.d/conda.sh"

conda activate spades

base=2057

spades.py -1 ${base}_trimmed_r1.fq.gz -2 ${base}_trimmed_r2.fq.gz -s ${base}_trimmed_unp.fq.gz --careful --cov-cutoff auto -o ${base}_spades_out
