#!/bin/bash

# Created by:         Emanuele Bugliarello (@e-bug)
# Date created:       9/4/2019
# Date last modified: 9/4/2019

src=en
tgt=vi
PROJ="."
INPUT=$PROJ/data/vlsp20envi/corpus
OUTPUT=$INPUT/vlsp20${src}2${tgt}

# Binarize the dataset:
python fairseq_cli/preprocess.py \
	--source-lang $src \
	--target-lang $tgt \
	--trainpref $INPUT/train.tok.tok.bpe.16000 \
	--validpref $INPUT/valid.tok.tok.bpe.16000 \
	--testpref $INPUT/test.tok.tok.bpe.16000 \
	--destdir $OUTPUT \
	--workers 16 \
	--nwordssrc 16384 \
	--nwordstgt 16384 \
	--joined-dictionary
