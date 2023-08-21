#!/bin/bash

# Created by:         Emanuele Bugliarello (@e-bug)
# Date created:       9/4/2019
# Date last modified: 9/4/2019

src=en
tgt=vi
PROJ="."
INPUT=$PROJ/data/vlsp20envi/tags_mean
OUTPUT=$INPUT/vlsp20${src}2${tgt}

# Binarize the dataset:
python fairseq_cli/preprocess.py \
	--source-lang $src \
	--target-lang $tgt \
	--trainpref $INPUT/train \
	--validpref $INPUT/valid \
	--testpref $INPUT/test \
	--destdir $OUTPUT \
	--workers 16 \
	--only-source
