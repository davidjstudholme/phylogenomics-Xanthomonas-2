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

conda activate fastp

WINSIZ=5
MEANQUAL=20
MINLEN=50

base=2057

mkdir ${base}_fastp_out

fastp -i ${base}_r1.fq.gz -I ${base}_r2.fq.gz -o ${base}_trimmed_r1.fq.gz -O ${base}_trimmed_r2.fq.gz --unpaired1 ${base}_trimmed_unp.fq.gz --unpaired2 ${base}_trimmed_unp.fq.gz -r --cut_right_window_size $WINSIZ --cut_right_mean_quality $MEANQUAL -c -l $MINLEN -j ${base}_fastp_out/${base}_fastp_report.json -h ${base}_fastp_out/${base}_fastp_report.html
