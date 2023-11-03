# compound_potential
Compound processing potential assessments derived from metagenomes of human gut and environmental soil samples offer a new lens to explore the role of microbiota in human- and environmental-health.

**Contains code for the article:**

*Bioenergetic mapping of ‘healthy microbiomes’ via compound processing potential imprinted in gut and soil metagenomes*

by Craig Liddicoat, Robert A. Edwards, Michael Roach, Jake M. Robinson, Kiri Joy Wallace, Andrew D. Barnes, Joel Brame, Anna Heintz-Buschart, Timothy R. Cavagnaro, Elizabeth A. Dinsdale, Michael P. Doane, Nico Eisenhauer, Grace Mitchell, Bibishan Rai, Sunita Ramesh, Martin F. Breed

DOI: https://doi.org/ ... link tbc

**About this repository:** This repository documents code used in the above article, and is not intended for ongoing code development. Sub-folders contain separate README workflow documents and scripts relevant to each of 7 case study datasets (described below).

**Overview:** The article and scripts copied here (comprising linux code, SLURM submission scripts, snakefiles, python scripts, R code for data analysis) document the methodology used for extending [SUPER-FOCUS](https://github.com/metageni/SUPER-FOCUS) functional profiling of metagenome samples to derive measures of *compound processing potential* for major classes of compounds and specific molecules of interest. This methodology uses [ModelSEED Database](https://github.com/ModelSEED/ModelSEEDDatabase) (accessed 10-Aug-2022) resources to perform bioenergetic mapping via van Krevelen coordinates. Functions are converted to weighted mean reaction-level 'meta-compound' information based on carbon (C), hydrogen (H), and oxygen (O) content. Reaction-level O:C and H:C molar ratios are calculated to map functional relative abundances into the van Krevelen coordinate space. Zones in van Krevelen space are used to define major compound classes, while specific molecules are represented by particular van Krevelen coordinates.

Four compound processing potential (CPP) metrics were evaluated:
1. CPP-class values summed functional relative abundances mapping to major compound classes
2. CPP-ASALR: noting high variability in CPP-class values across case studies, we implemented a first-pass normalization aiming to account for microbial activity levels, based on CPP-class abundances assigned to amino sugars, here termed amino sugar adjusted log ratio (ASALR) data
3. CPP-density captured the density of functional relative abundances in close radial proximity to focus biomolecules
4. Compound-associated van Krevelen coordinates: these data underpin the above measures (i.e., aggregated within major classes, or within close radii of biomolecules) but were also used to consolidate functions with shared van Krevelen coordinates for supplementary analyses in selected case studies.

The new *compound processing potential* analysis was applied to existing published case study datasets from atherosclerotic cardiovascular disease (ACVD) using data from [Jie et al 2017](https://doi.org/10.1038/s41467-017-00900-1); colorectal cancer using data from [Zeller et al 2014](https://doi.org/10.15252/msb.20145645); type 2 diabetes using data from [Forslund et al 2015](https://doi.org/10.1038/nature15766); and childhood anxious-depressive behaviors using data from [Flannery et al 2020](https://doi.org/10.1128/mBio.02780-19).

We also used soil metagenome case study datasets published by the [Australian Microbiome Initiative (AMI)](https://data.bioplatforms.com/organization/australian-microbiome) (accessed 15-Sep-2022); from post-mining ecosystem restoration work published by [Sun and Badgley 2019](https://doi.org/10.1016/j.soilbio.2019.05.004); and previously unpublished pilot-scale soil metagenomics data from the [People, Cities and Nature](https://www.peoplecitiesnature.co.nz/soil-biodiversity) urban forest ecosystem restoration research program, from [Barnes et al 2023](https://data.agdr.org.nz/) (samples described by [Mitchell 2022](https://researchcommons.waikato.ac.nz/handle/10289/14915)).

**Note on reproducibility:** Metagenomics data were generally processed in three steps: (i) raw sequences were accessed/downloaded, (ii) QA/QC was performed to obtain good sequences, then (iii) functional profiles were derived using SUPER-FOCUS, all performed on Flinders University [DeepThought HPC](https://deepthoughtdocs.flinders.edu.au/en/latest/) linux high performance computer. SUPER-FOCUS results were downloaded to a local machine for further statistical analysis via [R script](/Compound-potential-R-code-final.R). Github folders used here to store copies of code reflect the structure (per case study datasets and processing steps) used for tasks on the HPC. However, any users attempting to follow this analysis will need to adapt the code to incorporate their own logical folder/filepath structures.
Software versions used were: Python (v3.8.5), FastQC (v0.11.9), Snakemake (v5.22.0), Fastp (v0.23.2), Diamond (v0.9.19), SUPER-FOCUS (v0.0.0), R (v4.2.2)
