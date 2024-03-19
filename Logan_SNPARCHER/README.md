# Running snpArcher on Terrapin Data Set 
## From snparcher docs
1. `mamba create -c conda-forge -c bioconda -n snparcher "snakemake==7.32.4" "python==3.11.4"`
2. `mamba activate snparcher` 
3. `cd` to location you want to clone to and `git clone https://github.com/harvardinformatics/snpArcher.git`
## The following replacements set configurations for running snparcher on the terrapin data located in `/scratch/lgh0053`
4. Replace `snparcher/config` directory with `VariantCallingWorking/Logan_SNPARCHER/config` directory (use `cp`)
5. Replace `snparcher/profiles/slurm/config.yaml` with `VariantCallingWorking/Logan_SNPARCHER/config.yaml`
6. Replace `snparcher/profiles/slurm/cluster_config.yml` with `VariantCallingWorking/Logan_SNPARCHER/cluster_config.yml`
7. Replace `snparcher/run_pipeline.sh` with `VariantCallingWorking/Logan_SNPARCHER/run_pipeline.sh` and make executable
8. Use `screen` to open new terminal session that won't time out
9. `./run_pipeline.sh`

## Screen commands
* `screen` opens new session
* control A + D exits sessions (but keeps it open)
* `screen -ls` lists open sessions
* `screen -r [session ID]` reconnects to session
* `screen -X -S [session ID] quit (or exit?)` closes the session
