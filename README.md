# compound_potential
Compound processing potential assessments derived from metagenomes of human gut and environmental soil samples offer a new lens to explore the role of microbiota in human- and environmental-health.

**Contains code for the article:**

*Bioenergetic mapping of ‘healthy microbiomes’ via compound processing potential imprinted in gut and soil metagenomes*

by Craig Liddicoat, Robert A. Edwards, Michael Roach, Jake M. Robinson, Andrew D. Barnes, Joel Brame, Anna Heintz-Buschart, Timothy R. Cavagnaro, Elizabeth A. Dinsdale, Michael P. Doane, Nico Eisenhauer, Grace Mitchell, Bibishan Rai, Sunita Ramesh, Kiri J. Wallace, Martin F. Breed

Scripts copied here (comprising linux code, SLURM submission scripts, snakefiles, python scripts, R code for data analysis) and the associated article (https://doi.org/ ... link tbc) demonstrate the methodology for extending [SUPER-FOCUS](https://github.com/metageni/SUPER-FOCUS) functional profiling of metagenome samples via bioenergetic mapping into van Krevelen coordinate space to derive measures of compound processing potential for major classes of compounds and specific molecules of interest.

Functions are converted to weighted mean reaction-level 'meta-compound' information based on carbon (C), hydrogen (H), and oxygen (O) content. Reaction-level O:C and H:C molar ratios are calculated to map functional relative abundances into the van Krevelen coordinate space. Zones in van Krevelen space are used to define major compound classes, while specific molecules correspond to particular van Krevelen coordinates.

Four compound processing potential (CPP) metrics were evaluated:
1. CPP-class values summed functional relative abundances mapping to major compound classes
2. CPP-ASALR: noting high variability in CPP-class values across case studies, we implemented a first-pass normalization aiming to account for microbial activity levels, based on CPP-class abundances assigned to amino sugars, here termed amino sugar adjusted log ratio (ASALR) data
3. CPP-density captured the density of functional relative abundances in close radial proximity to focus biomolecules
4. Compound-associated van Krevelen coordinates: these data underpin the above measures (i.e., aggregated within major classes, or within close radii of biomolecules) but were also used to consolidate functions with shared van Krevelen coordinates for supplementary analyses in selected case studies.

The new compound processing potential analysis was applied to existing published case study datasets from atherosclerotic cardiovascular disease (ACVD) by [Jie et al 2017](https://doi.org/10.1038/s41467-017-00900-1); colorectal cancer by [Zeller et al 2014](https://doi.org/10.15252/msb.20145645); type 2 diabetes by [Forslund et al 2015](https://doi.org/10.1038/nature15766); and childhood anxious-depressive behavioral disorders by [Flannery et al 2020](https://doi.org/10.1128/mBio.02780-19).

We also used soil metagenome case study datasets published by the [Australian Microbiome Initiative (AMI)](https://data.bioplatforms.com/organization/about/australian-microbiome) accessed in September 2022; from post-mining ecosystem restoration work published by [Sun and Badgley 2019](https://doi.org/10.1016/j.soilbio.2019.05.004); and previously unpublished pilot soil metagenomics data from the [People, Cities and Nature](https://www.peoplecitiesnature.co.nz/soil-biodiversity) urban forest ecosystem restoration research program, where samples are described by [Mitchell 2022](https://researchcommons.waikato.ac.nz/handle/10289/14915).

**Note on reproducibility:** Metagenomics data were processed in three steps: access/download raw sequences, perform QA/QC to obtain good sequences, then functional profiles were derived using SUPER-FOCUS, all performed on Flinders University [DeepThought HPC](https://deepthoughtdocs.flinders.edu.au/en/latest/) linux high performance computer. Results were downloaded to a local machine for statistical analysis via R script. The github folders used here to store copies of code used reflect the division of tasks by case study datasets and processing steps. However, the github folders will not exactly reflect the filepaths used in code that was run on DeepThought HPC or on the local machine. Any users attempting to follow this analysis will need to adapt the code to incorporate their own logical folder/filepath structures.
