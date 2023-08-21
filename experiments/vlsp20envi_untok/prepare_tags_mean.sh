PROJDIR="."
INDIR=$PROJDIR/data/vlsp20envi_untok/corpus
OUTDIR=$PROJDIR/data/vlsp20envi_untok/tags_mean
lang=en
TRAIN=train.tok.tok.bpe.16000.$lang
VALID=valid.tok.tok.bpe.16000.$lang
TEST=test.tok.tok.bpe.16000.$lang
SCRIPTSDIR=$PROJDIR/scripts_pascal

mkdir -p $OUTDIR

size=10000
i=0

python $SCRIPTSDIR/bpe_tags_mean_envi.py $lang $INDIR/$TEST $OUTDIR/test.$lang $size $i &
python $SCRIPTSDIR/bpe_tags_mean_envi.py $lang $INDIR/$VALID $OUTDIR/valid.$lang $size $i &

for i in {0..5}; do
  python $SCRIPTSDIR/bpe_tags_mean_envi.py $lang $INDIR/$TRAIN $OUTDIR/train.$lang.$i $size $i &
done

wait

rm $OUTDIR/train.$lang
for i in {0..5}; do
  cat $OUTDIR/train.$lang.$i >> $OUTDIR/train.$lang
done
rm $OUTDIR/train.$lang.*

read -p "Press any key to exit ..."