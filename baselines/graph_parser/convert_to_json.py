import json
import argparse
from src.col_data import read_col_data, convert_conllu_to_json


def main():
    """
    Converts the conllu format to sentiment graph jsons
    """
    parser = argparse.ArgumentParser()
    parser.add_argument("infile", help="the conllu file to be converted to json")
    parser.add_argument("outfile", help="the output json file")
    args = parser.parse_args()

    sentences = list(read_col_data(args.infile))

    json_sentences = convert_conllu_to_json(sentences)

    with open(args.outfile, "w") as outfile:
        json.dump(json_sentences, outfile)


if __name__ == "__main__":
    main()
