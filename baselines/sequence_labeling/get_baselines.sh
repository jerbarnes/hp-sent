#!/bin/bash

EMBEDDINGDIR="../graph_parser/embeddings"

python3 convert_to_bio.py
python3 convert_to_rels.py

EXTERNAL=$EMBEDDINGDIR/32.zip

# Train extraction models
for ANNOTATION in sources targets expressions; do
    python3 extraction_module.py -data multibooked_eu -emb "$EXTERNAL" -ann "$ANNOTATION"
done;

# Train relation prediction model
python3 relation_prediction_module.py -data multibooked_eu -emb "$EXTERNAL"

