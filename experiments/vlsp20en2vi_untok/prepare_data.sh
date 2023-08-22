#! /usr/bin/env bash

# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PROJ_DIR="."
OUTPUT_DIR="$PROJ_DIR/data/vlsp20envi_untok/corpus"
MOSES_DIR="$PROJ_DIR/tools/mosesdecoder"
BPE_DIR="$PROJ_DIR/tools/subword-nmt"
SCRIPTS_DIR="$PROJ_DIR/scripts_pascal"


# CoreNLP tokenize eng data, remain vi data
for f in ${OUTPUT_DIR}/*.tok.en; do
  fbase=${f%.*}
  echo "CoreNLP tokenizing ${fbase}.en..."
  python ${SCRIPTS_DIR}/encorenlp_tok.py $fbase &
  cp $fbase.vi $fbase.tok.vi
done

wait

# Learn Shared BPE
for merge_ops in 32000; do
  echo "Learning BPE with merge_ops=${merge_ops}. This may take a while..."
  cat "${OUTPUT_DIR}/train.tok.tok.vi" "${OUTPUT_DIR}/train.tok.tok.en" | \
    ${BPE_DIR}/subword_nmt/learn_bpe.py -s $merge_ops > "${OUTPUT_DIR}/bpe.${merge_ops}"
  echo "Apply BPE with merge_ops=${merge_ops} to tokenized files..."
  for lang in en vi; do
    for f in ${OUTPUT_DIR}/*tok.tok.${lang}; do
      outfile="${f%.*}.bpe.${merge_ops}.${lang}"
      ${BPE_DIR}/subword_nmt/apply_bpe.py -c "${OUTPUT_DIR}/bpe.${merge_ops}" < $f > "${outfile}"
    done
  done
done

echo "All done."
