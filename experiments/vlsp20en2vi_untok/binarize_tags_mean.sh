#!/bin/bash

# Created by:         Phan Dat
# Date created:       20/8/2023
# Date last modified: 20/8/2023

src=en
tgt=vi
PROJ="."
INPUT=$PROJ/data/vlsp20envi_untok/tags_mean
OUTPUT=$INPUT/vlsp20${src}2${tgt}_untok

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
