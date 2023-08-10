import multiprocessing
import re
import sys
import html
from nltk.parse.corenlp import CoreNLPParser

parser = CoreNLPParser(url='http://localhost:6666')


def tokenize_en(sent):
    sent = html.unescape(sent.strip())
    sent = re.sub('([\.!?])([A-Z])', '\g<1> \g<2>', sent)
    sent = ' '.join(parser.tokenize(sent))
    return sent


if __name__ == "__main__":
    path = sys.argv[1]
    lang = 'en'
    with open(path + '.' + lang, encoding='utf8') as f:
        en_lines = f.readlines()

    pool = multiprocessing.Pool()
    en_tok = pool.map(tokenize_en, en_lines)

    pool.close()

    with open(path + '.tok.en', 'w', encoding='utf8') as f:
        for line in en_tok:
            f.write(line + '\n')
