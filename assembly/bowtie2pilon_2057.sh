#!/bin/bash
#SBATCH --export=ALL # export all environment variables to the batch job
#SBATCH -D . # set working directory to .
#SBATCH -p bioseq # submit to the parallel queue (pq)mrc queue(mrcq)serial queue(sq)
#SBATCH --time=5:00:00 # maximum walltime for the job
#SBATCH -A research_project-bioproduction  # research project to submit under
#SBATCH --nodes=1 # specify number of nodesq pq
#SBATCH --ntasks-per-node=7 # specify number of processors per node
#SBATCH --mail-type=END # send email at job completion
#SBATCH --mail-user=j.w.harrison@exeter.ac.uk # email address

. "/gpfs/ts0/projects/Research_Project-BioSandbox/miniconda3/etc/profile.d/conda.sh"

base=2057

conda activate bowtie2

bowtie2-build ${base}.fasta ${base}

bowtie2 -x ${base} -1 /gpfs/ts0/projects/Research_Project-T114269/Xanthomonas_BPD/trimming/fastp/all_fastq_260521_Q20_L50/${base}_trimmed_r1.fq.gz -2  /gpfs/ts0/projects/Research_Project-T114269/Xanthomonas_BPD/trimming/fastp/all_fastq_260521_Q20_L50/${base}_trimmed_r2.fq.gz -S ${base}_vs_${base}.sam

conda activate samtools

samtools view -b -T ${base}.fasta ${base}_vs_${base}.sam -o ${base}_vs_${base}.sam.bam

samtools sort --reference ${base}.fasta ${base}_vs_${base}.sam.bam -o ${base}_vs_${base}.sam.bam.sorted.bam

samtools index ${base}_vs_${base}.sam.bam.sorted.bam

conda activate pilon

pilon --genome ${base}.fasta --frags ${base}_vs_${base}.sam.bam.sorted.bam --output ${base}.pilon --outdir ${base}_pilon_out

rm ${base}_vs_${base}.sam.bam ${base}_vs_${base}.sam
