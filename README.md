## SemEval-2022 Shared Task 10: Structured Sentiment Analysis

This Github repository hosts the data and baseline models for the [SemEval-2022 shared task 10](https://competitions.codalab.org/competitions/33556) on structured sentiment. In this repository you will find the datasets, baselines, and other useful information on the shared task.


## Table of contents:

1. [Problem description](#problem-description)
2. [Evaluation](#evaluation)
3. [Data format](#data-format)
4. [Resources](#resources)
5. [Baselines](#baselines)
6. [Citation](#citation)

## Problem description

The task is to predict all structured sentiment graphs in a text (see the examples below). We can formalize this as finding all the opinion tuples *O* = *O*<sub>i</sub>,...,*O*<sub>n</sub> in a text. Each opinion *O*<sub>i</sub> is a tuple *(h, t, e, p)*

where *h* is a **holder** who expresses a **polarity** *p* towards a **target** *t* through a **sentiment expression** *e*, implicitly defining the relationships between the elements of a sentiment graph.

The two examples below (first in English, then in Basque) give a visual representation of these *sentiment graphs*.

![multilingual example](./figures/multi_sent_graph.png)

Participants can then either approach this as a sequence-labelling task, or as a graph prediction task.


| Dataset | Language | # sents | # holders | # targets | # expr. |
| --------| -------- | ------- | --------- | --------- | ------- |
| [MultiBooked_eu](https://aclanthology.org/L18-1104/) | Basque |1521 |296 |1775 |2328 |


## Evaluation

The two subtasks will be evaluated separately. In both tasks, the evaluation will be based on [Sentiment Graph F<sub>1</sub>](https://arxiv.org/abs/2105.14504).


This metric defines true positive as an *exact match* at
graph-level, *weighting the overlap* in predicted and
gold spans for each element, averaged across all
three spans.

For *precision* we weight the number
of correctly predicted tokens divided by the total
number of predicted tokens (for *recall*, we divide
instead by the number of gold tokens), allowing
for empty holders and targets which exist in the gold standard.


## Data format

We provide the data in json lines format.

Each line is an annotated sentence, represented as a dictionary with the following keys and values:

* `'sent_id'`: unique sentence identifiers

* `'text'`: raw text version of the previously tokenized sentence

* `opinions'`: list of all opinions (dictionaries) in the sentence

Additionally, each opinion in a sentence is a dictionary with the following keys and values:

* `'Source'`: a list of text and character offsets for the opinion holder

* `'Target'`: a list of text and character offsets for the opinion target

* `'Polar_expression'`: a list of text and character offsets for the opinion expression

* `'Polarity'`: sentiment label ('Negative', 'Positive', 'Neutral')

* `'Intensity'`: sentiment intensity ('Average', 'Strong', 'Weak')


```
{
    "sent_id": "../opener/en/kaf/hotel/english00164_c6d60bf75b0de8d72b7e1c575e04e314-6",

    "text": "Even though the price is decent for Paris , I would not recommend this hotel .",

    "opinions": [
                 {
                    "Source": [["I"], ["44:45"]],
                    "Target": [["this hotel"], ["66:76"]],
                    "Polar_expression": [["would not recommend"], ["46:65"]],
                    "Polarity": "Negative",
                    "Intensity": "Average"
                  },
                 {
                    "Source": [[], []],
                    "Target": [["the price"], ["12:21"]],
                    "Polar_expression": [["decent"], ["25:31"]],
                    "Polarity": "Positive",
                    "Intensity": "Average"}
                ]
}
```

You can import the data by using the json library in python:

```
>>> import json
>>> with open("data/norec/train.json") as infile:
            norec_train = json.load(infile)
```

## Resources:
The task organizers provide training data, but participants are free to use other resources (word embeddings, pretrained models, sentiment lexicons, translation lexicons, translation datasets, etc). We do ask that participants document and cite their resources well.

We also provide some links to what we believe could be helpful resources:

1. [pretrained word embeddings](http://vectors.nlpl.eu/repository/)
2. [pretrained language models](https://huggingface.co/models)
3. [translation data](https://opus.nlpl.eu/)
4. [sentiment resources](https://github.com/jerbarnes/sentiment_resources)
5. [syntactic parsers](https://stanfordnlp.github.io/stanza/)


## Baselines

The task organizers provide two baselines: one that takes a sequence-labelling approach and a second that converts the problem to a dependency graph parsing task. You can find both of them in [baselines](./baselines).


## Citation

If you use the baselines or data from this shared task, please cite the following paper, as well as the papers for the specific datasets that you use (see the bib files that follow afterwards) :

```
@inproceedings{barnes-etal-2022-semeval,
    title = "{S}em{E}val-2022 Task 10: Structured Sentiment Analysis",
    author = "Barnes, Jeremy and
              Oberl{\"a}nder, Laura Ana Maria and
              Troiano, Enrica and
              Kutuzov, Andrey and
              Buchmann, Jan and
              Agerri, Rodrigo and
              {\O}vrelid, Lilja  and
              Velldal, Erik",
    booktitle = "Proceedings of the 16th International Workshop on Semantic Evaluation (SemEval-2022)",
    month = july,
    year = "2022",
    address = "Seattle",
    publisher = "Association for Computational Linguistics"
}
```


MultiBooked

```
@inproceedings{barnes-etal-2018-multibooked,
    title = "{M}ulti{B}ooked: A Corpus of {B}asque and {C}atalan Hotel Reviews Annotated for Aspect-level Sentiment Classification",
    author = "Barnes, Jeremy  and
      Badia, Toni  and
      Lambert, Patrik",
    booktitle = "Proceedings of the Eleventh International Conference on Language Resources and Evaluation ({LREC} 2018)",
    month = may,
    year = "2018",
    address = "Miyazaki, Japan",
    publisher = "European Language Resources Association (ELRA)",
    url = "https://aclanthology.org/L18-1104",
}
```
