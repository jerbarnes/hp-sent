Usage
-------------
Use this script to create contextualized token embeddings using any pretrained language model from huggingface transformers.

--model is the name of a huggingface model, e.g. 'bert-base-multilingual-cased'

--indata expects a converted conllu format, which should be created in the baselines/graph_parser/sentiment_graph repository when you create the graph baseline.

--outdata will create an hdf5 file


```
python context_embed.py --model bert-base-multilingual-cased --indata ../baselines/graph_parser/sentiment_graphs/multibooked_eu/head_final/train.conllu --outdata train.hdf5

```

You will need to create these for the train, dev, and test splits of the dataset.


You can then use them with to train the graph_parser baseline with contextualized embeddings:


```
python3 ./src/main.py --config configs/sgraph.cfg --train sentiment_graphs/multibooked_eu/head_final/train.conllu --val sentiment_graphs/multibooked_eu/head_final/dev.conllu --predict_file sentiment_graphs/multibooked_eu/head_final/test.conllu --dir experiments/multibooked_eu/head_final/ --external embeddings/32.zip --context_emb_train ../../contextual_embeddings/train.hdf5 --context_emb_dev ../../contextual_embeddings/dev.hdf5 --context_emb_test ../../contextual_embeddings/test.hdf5 --use_context_emb True --vec_dim 768

```
