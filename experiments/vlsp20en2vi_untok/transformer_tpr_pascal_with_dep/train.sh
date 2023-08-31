#!/bin/bash

# Created by:         Phan Dat
# Date created:       20/8/2023
# Date last modified: 20/8/2023

DATADIR=./data/vlsp20envi_untok/corpus/vlsp20en2vi_untok
TAGSDIR=./data/vlsp20envi_untok/tags_mean/vlsp20en2vi_untok
DEPSDIR=./data/vlsp20envi_untok/tags_label/vlsp20en2vi_untok
CKPTS=./experiments/vlsp20en2vi_untok/transformer_tpr_pascal_with_dep/train_log

params="$DATADIR \
--save-dir $CKPTS \
--tags-data $TAGSDIR \
--deps-data $DEPSDIR \
--num_roles 50 \
--encoder_role_weights_input dependency \
--decoder_role_weights_input v_bar \
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
--lr 0.001 \
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
--arch tpr_pascal_transformer_with_dep \
--task deps_tags_translation \
"

mkdir -p $CKPTS

python train.py $params

read -p "Exit..."