#!/bin/bash
# Set some random seeds that will be the same for all experiments
SEED=17181920

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
    OUTDIR=experiments/multibooked_eu/$SETUP;
    mkdir experiments/multibooked_eu/$SETUP;
    # If a model is already trained, don't retrain
    if [ -f "$OUTDIR"/test.conllu.pred ]; then
        echo "multibooked_eu-$SETUP already trained"
    else
        mkdir logs/multibooked_eu/$SETUP;
        LOGFILE=logs/multibooked_eu/$SETUP/log.txt
        DIR=experiments/multibooked_eu/$SETUP
        echo saving experiment to $DIR

        TRAIN=sentiment_graphs/multibooked_eu/"$SETUP"/train.conllu
        DEV=sentiment_graphs/multibooked_eu/"$SETUP"/dev.conllu
        TEST=sentiment_graphs/multibooked_eu/"$SETUP"/test.conllu
        EXTERNAL=embeddings/32.zip

        rm -rf $DIR
        mkdir -p $DIR

        python3 ./src/main.py --config configs/sgraph.cfg --train $TRAIN --val $DEV --predict_file $TEST --dir $DIR --external $EXTERNAL --seed $SEED
    fi
done;
