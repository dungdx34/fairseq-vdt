#!/bin/bash

# Created by:         Emanuele Bugliarello (@e-bug)
# Date created:       9/4/2019
# Date last modified: 9/4/2019

DATADIR=./data/vlsp20envi/corpus/vlsp20en2vi
TAGSDIR=./data/vlsp20envi/tags_mean/vlsp20en2vi
CKPTS=./experiments/vlsp20en2vi/transformer_tpr_pascal/train_log

params="./data/vlsp20envi/corpus/vlsp20en2vi \
--save-dir ./experiments/vlsp20en2vi/transformer_tpr_pascal/train_log \
--tags-data ./data/vlsp20envi/tags_mean/vlsp20en2vi \
--num_roles 50 \
--encoder-pascal-heads 7 0 0 0 0 0 \
--dropout 0.3 \
--parent-ignoring 0.3 \
--share-all-embeddings \
--optimizer adam \
--adam-betas (0.9,0.98) \
--adam-eps 1e-09 \
--clip-norm 0.0 \
--lr-scheduler inverse_sqrt \
--warmup-init-lr 1e-07 \
--warmup-updates 8000 \
--lr 0.0007 \
--min-lr 1e-09 \
--weight-decay 0.0 \
--criterion label_smoothed_cross_entropy \
--label-smoothing 0.1 \
--max-tokens 4096 \
--max-update 20000 \
--no-progress-bar \
--log-format json \
--log-interval 100 \
--save-interval 500000 \
--save-interval-updates 500 \
--keep-interval-updates 1 \
--arch tpr_pascal_transformer \
--task tags_translation \
"

mkdir -p $CKPTS

python train.py $params
