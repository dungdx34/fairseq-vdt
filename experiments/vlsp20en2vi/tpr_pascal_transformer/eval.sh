export CUDA_VISIBLE_DEVICES=0
src=en
tgt=vi
PROJ_PATH=./experiments/vlsp20${src}2${tgt}
DATA_PATH=./data/vlsp20envi/corpus/vlsp20en2vi
CKPT_PATH=$PROJ_PATH/tpr_pascal_transformer/train_log
MODEL_DIR=$PROJ_PATH/tpr_pascal_transformer
OUTPUT_FN=$MODEL_DIR/res.txt
mosesdecoder=./tools/mosesdecoder

mkdir -p $MODEL_DIR/outputs

for split in valid test; do
  python ./fairseq_cli/generate.py $DATA_PATH \
          --gen-subset $split \
          --path $CKPT_PATH/checkpoint_last.pt \
          --batch-size 128 \
  	  --remove-bpe \
          --beam 4 \
          --lenpen 0.6 \
          > $OUTPUT_FN

  # Extract source, predictions and ground truth
  grep '^S-[0-9]*' $OUTPUT_FN | sed 's|^..||' | sort -k1 -n | cut -f2 > $MODEL_DIR/outputs/src.tok.$split
  grep '^H-[0-9]*' $OUTPUT_FN | sed 's|^..||' | sort -k1 -n | cut -f3 > $MODEL_DIR/outputs/preds.tok.$split
  grep '^T-[0-9]*' $OUTPUT_FN | sed 's|^..||' | sort -k1 -n | cut -f2 > $MODEL_DIR/outputs/truth.tok.$split

  # Detokenize
  perl $mosesdecoder/scripts/tokenizer/detokenizer.perl -q -l $tgt \
          < $MODEL_DIR/outputs/preds.tok.$split \
          > $MODEL_DIR/outputs/preds.detok.$split
  perl $mosesdecoder/scripts/tokenizer/detokenizer.perl -q -l $tgt \
          < $MODEL_DIR/outputs/truth.tok.$split \
          > $MODEL_DIR/outputs/truth.detok.$split

  # Fix some moses detokenization
  sed "s| '|'|g" $MODEL_DIR/outputs/preds.detok.$split | sed "s| /|/|g" | sed "s|/ |/|g" | sed "s| @ - @ |-|g" \
  	  > $MODEL_DIR/outputs/preds.$split
  sed "s| '|'|g" $MODEL_DIR/outputs/truth.detok.$split | sed "s| /|/|g" | sed "s|/ |/|g" | sed "s| @ - @ |-|g" \
          > $MODEL_DIR/outputs/truth.$split
  rm $MODEL_DIR/outputs/preds.detok.$split $MODEL_DIR/outputs/truth.detok.$split

  # Compute BLEU
  if [ $split == valid ]; then
    cat $MODEL_DIR/outputs/preds.$split | sacrebleu -t wmt16 -l $src-$tgt > $MODEL_DIR/bleu.$split
  else
    cat $MODEL_DIR/outputs/preds.$split | sacrebleu -t wmt17 -l $src-$tgt > $MODEL_DIR/bleu.$split
  fi

done

rm $OUTPUT_FN
