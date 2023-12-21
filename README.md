# Phylogenomic Analysis Supports the Transfer of 20 Pathovars from _Xanthomonas campestris_ into _Xanthomonas euvesicatoria_
Transfer of 20 pathovars from _X. campestris_ to _X. euvesicatoria_

**Harrison, J.; Hussain, R.M.F.; Aspin, A.; Grant, M.R.; Vicente, J.G.; Studholme, D.J. (2023)**. Phylogenomic Analysis Supports the Transfer of 20 Pathovars from _Xanthomonas campestris_ into _Xanthomonas euvesicatoria_. _Taxonomy_ 3, 29-45. https://doi.org/10.3390/taxonomy3010003

Central to that paper is a phylogenomic tree presented in Figure 1. Here we present the methods used to generate that tree and other analyses in the manuscript.

- The phylogenomic tree is  available for view, download and editing at IToL here: https://itol.embl.de/tree/31532436257011668934683.


### Get this repo
```
git clone https://github.com/davidjstudholme/phylogenomics-Xanthomonas-2.git
```

### Download _datasets_ from the NCBI's command line tools
```
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v1/linux-amd64/datasets'
chmod u+x datasets
```

### Create genomes/ directory and download genome assemblies 
```
mkdir genomes
```

### Enter the genomes/ directory
```
cd genomes
```

### Download genome sequences into the genomes/ directory
The list of genomes to be downloaded by the _datasets_ tool is specified in this file: [xanthomonas_assm_accs.txt](./xanthomonas_assm_accs.txt) **Check this file**.
```
ln -s ../phylogenomics-Xanthomonas-2/xanthomonas_assm_accs.txt .
ln -s ../datasets .
./datasets download genome accession --inputfile xanthomonas_assm_accs.txt  --exclude-gff3 --exclude-protein --exclude-rna --exclude-genomic-cds --filename xanthomonas_genome_assemblies.zip

unzip xanthomonas_genome_assemblies.zip
ln -s ncbi_dataset/data/GCA_*/GCA_*.fna .
ls *.fna
```

### Rename the genome sequence files with names of the bacterial strains
This step uses a Perl script [rename_files.pl](./rename_files.pl) to generate symbolic links to each genome,
with more informative names that can be used for input into PhaME. The genomes and their informative names are specified in
file [genomes.txt](./genomes.txt).
```
perl ../phylogenomics-Xanthomonas-2/rename_files.pl  ../phylogenomics-Xanthomonas-2/genomes.txt
```

### Exit the genomes/ direcory
```
cd -
```

### Set-up the ref/ directory
**Check reference genome**
```
mkdir ref
cd ref
ln -s ../genomes/X._campestris_pv._campestris_ATCC_33913_T_PT.fasta .
cd -
```

### Set-up the workdir/ directory
```
mkdir workdir
cd workdir
ln -s ../genomes/*.contig .
cd -
```

### Run PhaME
**Shakya, M., Ahmed, S.A., Davenport, K.W. et al.** (2020). Standardized phylogenetic and molecular evolutionary
analysis applied to species across the microbial tree of life. _Sci Rep_ 10, 1723.https://doi.org/10.1038/s41598-020-58356-1

Phame requires a configuration file [phame.fasttree.ctl](./phame.fasttree.ctl).
This assumes that you have already created a Conda envirinment called _phame_env_ and installed PhaME into it.
This step can take a long time, so it is recommended to run it inside a _screen_ session.
```
screen
conda activate phame_env
cp phylogenomics-Xanthomonas-2/phame.fasttree.ctl .
phame ./phame.ctl
```
This generates a bootstrapped tree [test_all.fasttree](./phaME_output/test_all.fasttree).

### Calculate average nucleotide identity using fastANI
This assumes that you have already created a Conda envirinment called _fastani_env_ and installed fastANI into it.
This step can take a long time, so it is recommended to run it inside a _screen_ session.
Input files are required, which list the genomes to be included in the ANI calculations:
- [query_list.txt](./ANI/query_list.txt)
- [ref_list.txt](./ANI/ref_list.txt)
```
screen
conda activate fastani_env
fastANI --ql query_list.txt --rl ref_list.txt -o all-versus-all.fastANI.out -t 6 --visualize --matrix
```
This generates these output files:
- [all-versus-all.fastANI.out](./ANI/all-versus-all.fastANI.out)
- [all-versus-all.fastANI.out.matrix](./ANI/all-versus-all.fastANI.out.matrix)
