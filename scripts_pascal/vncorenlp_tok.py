import re
import sys
import html
import multiprocessing
from vncorenlp import VnCoreNLP
import logging


def tokenize_vi(sent):
    sent = html.unescape(sent.strip())
    sent = re.sub('([\.!?])([A-Z])', '\g<1> \g<2>', sent)
    sent = ' '.join(parser.tokenize(sent)[0])
    print(sent)
    return sent


if __name__ == "__main__":
    path = sys.argv[1]

    lang = 'vi'
    with open(path + '.' + lang, 'r', encoding='utf8') as f:
        vi_lines = f.readlines()
    print(len(vi_lines))

    # absolute path to vncorenlp jar file
    vncorenlp_path = "F:/MyDocuments/VnCoreNLP-master/VnCoreNLP-1.2.jar"
    parser = VnCoreNLP(vncorenlp_path)

    vi_tok = list(map(tokenize_vi, vi_lines))

    with open(path + '.tok.vi', 'w', encoding='utf8') as f:
        for line in vi_tok:
            f.write(line + '\n')

    parser.close()

