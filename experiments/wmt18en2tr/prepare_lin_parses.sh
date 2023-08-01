#!/bin/bash

# Created by:         Emanuele Bugliarello (@e-bug)
# Date created:       9/4/2019
# Date last modified: 9/4/2019

PROJDIR=/home/hnc/PycharmProjects/fairseq-vdt
INDIR=$PROJDIR/data/wmt18tren/corpus
OUTDIR=$PROJDIR/data/wmt18tren/lin_parses
lang=en
TRAIN=train.tok.tok.bpe.16000.$lang
VALID=valid.tok.tok.bpe.16000.$lang
TEST=test.tok.tok.bpe.16000.$lang
SCRIPTSDIR=$PROJDIR/scripts_pascal

#source activate pascal

mkdir -p $OUTDIR

size=10000
i=0

python $SCRIPTSDIR/bpe_lin_parses.py $lang $INDIR/$TEST $OUTDIR/test.$lang $size $i &
python $SCRIPTSDIR/bpe_lin_parses.py $lang $INDIR/$VALID $OUTDIR/valid.$lang $size $i &

for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do
  python $SCRIPTSDIR/bpe_lin_parses.py $lang $INDIR/$TRAIN $OUTDIR/train.$lang.$i $size $i &
done

wait

rm $OUTDIR/train.$lang
for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do
  cat $OUTDIR/train.$lang.$i >> $OUTDIR/train.$lang
done
rm $OUTDIR/train.$lang.*

#conda deactivate
