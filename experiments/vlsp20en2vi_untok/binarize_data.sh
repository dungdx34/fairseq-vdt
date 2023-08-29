#!/bin/bash

# Created by:         Phan Dat
# Date created:       20/8/2023
# Date last modified: 20/8/2023

src=en
tgt=vi
PROJ="."
INPUT=$PROJ/data/vlsp20envi_untok/corpus
OUTPUT=$INPUT/vlsp20${src}2${tgt}_untok

# Binarize the dataset:
python fairseq_cli/preprocess.py \
	--source-lang $src \
	--target-lang $tgt \
	--trainpref $INPUT/train.tok.tok.bpe.32000 \
	--validpref $INPUT/valid.tok.tok.bpe.32000 \
	--testpref $INPUT/test.tok.tok.bpe.32000 \
	--destdir $OUTPUT \
	--workers 16 \
	--nwordssrc 32768 \
	--nwordstgt 32768 \
	--joined-dictionary
