#!/bin/bash
# Set some random seeds that will be the same for all experiments
SEEDS=(17181920)

# Setup directories
mkdir logs
mkdir experiments

# # Convert json files to conllu for training
# # Currently only creates head_final, but you can
# # experiment with other graph setups by expanding this section
python3 convert_to_conllu.py --json_dir ../../data/multibooked_eu --out_dir sentiment_graphs/multibooked_eu --setup head_final

# Download basque word vectors
if [ -d embeddings ]; then
    echo "Using downloaded word embeddings"
else
    mkdir embeddings
    cd embeddings
    wget http://vectors.nlpl.eu/repository/20/32.zip
cd ..
fi


mkdir logs/multibooked_eu;
mkdir experiments/multibooked_eu;
# Iterate over the graph setups (head_final, head_first, head_final-inside_label, head_final-inside_label-dep_edges, head_final-inside_label-dep_edges-dep_labels, etc)
# Currently, just use head_final, but you can use others
for SETUP in head_final; do
    mkdir experiments/multibooked_eu/$SETUP;
    echo "Running multibooked_eu - $SETUP"
    SEED=${SEEDS[0]}
    OUTDIR=experiments/multibooked_eu/$SETUP;
    mkdir experiments/multibooked_eu/$SETUP;
    # If a model is already trained, don't retrain
    if [ -f "$OUTDIR"/test.conllu.pred ]; then
        echo "multibooked_eu-$SETUP already trained"
    else
        mkdir logs/multibooked_eu/$SETUP;
        LOGFILE=logs/multibooked_eu/$SETUP/log.txt
        bash ./sentgraph.sh  multibooked_eu $SETUP $SEED > $LOGFILE
    fi
done;
