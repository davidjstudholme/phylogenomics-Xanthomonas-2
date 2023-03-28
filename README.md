# phylogenomics-Xanthomonas-2
Transfer of 20 pathovars from X. campestris to X. euvesicatoria

```
### Get this repo
git clone https://github.com/davidjstudholme/phylogenomics-Xanthomonas-2.git

### Download NCBI Datasets command line tools
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v1/linux-amd64/datasets'
chmod u+x datasets 

### Create genomes directory and download genome assemblies 
mkdir genomes
cd genomes

ln -s ../phylogenomics-Xanthomonas-2/xanthomonas_assm_accs.txt .
ln -s ../datasets .
./datasets download genome accession --inputfile xanthomonas_assm_accs.txt  --exclude-gff3 --exclude-protein --exclude-rna --exclude-genomic-cds --filename xanthomonas_genome_assemblies.zip

unzip xanthomonas_genome_assemblies.zip
ln -s ncbi_dataset/data/GCA_*/GCA_*.fna .
ls *.fna
perl ../phylogenomics-Xanthomonas-2/rename_files.pl  ../phylogenomics-Xanthomonas-2/genomes.txt

cd -

### Set-up the ref/ directory
mkdir ref
cd ref
ln -s ../genomes/X._campestris_pv._campestris_ATCC_33913_T_PT.fasta .
cd -

### Set-up the workdir/ directory
mkdir workdir
cd workdir
ln -s ../genomes/*.contig .
cd -

### Run PhaME
### Shakya, M., Ahmed, S.A., Davenport, K.W. et al. Standardized phylogenetic and molecular evolutionary analysis applied to species across the microbial tree of life. Sci Rep 10, 1723 (2020). https://doi.org/10.1038/s41598-020-58356-1

screen
conda activate phame_env
cp phylogenomics-Xanthomonas-2/phame.fasttree.ctl .
phame ./phame.ctl


```


