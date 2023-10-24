## Workflow on DeepThought HPC - Post-mining forest restoration case study, from Sun & Badgley 2019

Notes:
- $WORKING_DIRECTORY and $LOCAL_WORKING_DIRECTORY should be substituted for appropriate folder paths
- The $USERNAME, $PASSWORD, and $AUTHORISATION_TOKEN used here are for the [MG-RAST](https://www.mg-rast.org/) system
- [DeepThought HPC](https://deepthoughtdocs.flinders.edu.au/en/latest/) uses [SLURM](https://deepthoughtdocs.flinders.edu.au/en/latest/SLURM/SLURMIntro.html) job submission/queuing/management software

&nbsp;

**Step 1. Inspect & download screened fasta files from [MG-RAST](https://www.mg-rast.org/)**

Using [MG-RAST tools](https://github.com/MG-RAST/MG-RAST-Tools) inspect available files for this case study (project mgp16379)

```Shell
cd $WORKING_DIRECTORY/sunbad-resto/sunbad-resto_1_meta_raw
mg-download.py --user $USERNAME, --passwd $PASSWORD --token $AUTHORISATION_TOKEN --project mgp16379 --list | sed 's/\t.*$//g' | sed '1d' | uniq > metagenomes.list
```

Raw fastq files are not available.
So instead download screened fasta files using script *[sunbad-resto-MGRAST_meta_mgrast_screened_download.sh](sunbad-resto_2_mgrast_screened/sunbad-resto-MGRAST_meta_mgrast_screened_download.sh)*

```Shell
cd $WORKING_DIRECTORY/sunbad-resto/sunbad-resto_2_mgrast_screened
sbatch sunbad-resto-MGRAST_meta_mgrast_screened_download.sh
```

&nbsp;

**Step 2. Perform QA/QC**

QA/QC were not undertaken as this case study used [screened](https://help.mg-rast.org/user_manual.html#the-mg-rast-pipeline) fasta files direct from MG-RAST

&nbsp;

**Step 3. Perform [SUPER-FOCUS](https://github.com/metageni/SUPER-FOCUS) functional annotation**

This runs the python script *[sunbad-resto_3_superfocus_fxns_hpc.py](sunbad-resto_3_superfocus_fxns/sunbad-resto_3_superfocus_fxns_hpc.py)*.

The python script writes and submits a separate SLURM submission file for each sample, with all files copied to [job_files](sunbad-resto_3_superfocus_fxns/job_files)

```Shell
cd $WORKING_DIRECTORY/sunbad-resto_3_superfocus_fxns
sbatch run__sunbad-resto_3_superfocus_fxns_hpc.sh
```
List sub-folders containing SUPER-FOCUS outputs for each sample, and copy to text file
```Shell
ls -d */
```
Then on local machine create corresponding results folders
```Shell
cd $LOCAL_WORKING_DIRECTORY/sunbad-resto
xargs mkdir <sunbad-resto-superfocus-folder-list.txt
```

Now using FileZilla FTP, download all *output_all_levels_and_function.xls* results files for each sequence from HPC to Local machine.
Proceed with data analysis in R
