#!/bin/bash

# Created by:         Emanuele Bugliarello (@e-bug)
# Date created:       9/4/2019
# Date last modified: 9/4/2019

src=en
tgt=tr
PROJ=/home/hnc/PycharmProjects/fairseq-vdt
INPUT=$PROJ/data/wmt18tren/tags_label
OUTPUT=$INPUT/wmt18${src}2${tgt}

# activate environment
#source activate pascal

# Binarize the dataset:
cd $PROJ/fairseq_cli
python preprocess.py \
	--source-lang $src \
	--target-lang $tgt \
	--trainpref $INPUT/train \
	--validpref $INPUT/valid \
	--testpref $INPUT/test \
	--destdir $OUTPUT \
	--workers 16 \
	--only-source

# deactivate environment
#conda deactivate
