# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

from .adaptive_input import AdaptiveInput
from .adaptive_softmax import AdaptiveSoftmax
from .beamable_mm import BeamableMM
from .character_token_embedder import CharacterTokenEmbedder
from .conv_tbc import ConvTBC
from .cross_entropy import cross_entropy
from .downsampled_multihead_attention import DownsampledMultiHeadAttention
from .dynamic_convolution import DynamicConv, DynamicConv1dTBC
from .dynamic_crf_layer import DynamicCRF
from .fp32_group_norm import Fp32GroupNorm
from .gelu import gelu, gelu_accurate
from .grad_multiply import GradMultiply
from .gumbel_vector_quantizer import GumbelVectorQuantizer
from .kmeans_vector_quantizer import KmeansVectorQuantizer
from .layer_drop import LayerDropModuleList
from .layer_norm import Fp32LayerNorm, LayerNorm
from .learned_positional_embedding import LearnedPositionalEmbedding
from .lightweight_convolution import LightweightConv, LightweightConv1dTBC
from .linearized_convolution import LinearizedConvolution
from .multihead_attention import MultiheadAttention
from .multihead_pascal import MultiheadPascal
from .multihead_tpr_attention import MultiheadTPRAttention
from .multihead_tpr_pascal import MultiheadTPRPascal
from .tpr_transformer_layer import TPRTransformerDecoderLayer, TPRTransformerEncoderLayer
from .positional_embedding import PositionalEmbedding
from .scalar_bias import ScalarBias
from .sinusoidal_positional_embedding import SinusoidalPositionalEmbedding
from .transformer_sentence_encoder_layer import TransformerSentenceEncoderLayer
from .transformer_sentence_encoder import TransformerSentenceEncoder
from .unfold import unfold1d
from .transformer_layer import TransformerDecoderLayer, TransformerEncoderLayer, PascalTransformerEncoderLayer
from .tpr_pascal_transformer_layer import TPRPascalTransformerEncoderLayer
from .vggblock import VGGBlock

__all__ = [
    'AdaptiveInput',
    'AdaptiveSoftmax',
    'BeamableMM',
    'CharacterTokenEmbedder',
    'ConvTBC',
    'cross_entropy',
    'DownsampledMultiHeadAttention',
    'DynamicConv1dTBC',
    'DynamicConv',
    'DynamicCRF',
    'Fp32GroupNorm',
    'Fp32LayerNorm',
    'gelu',
    'gelu_accurate',
    'GradMultiply',
    'GumbelVectorQuantizer',
    'KmeansVectorQuantizer',
    'LayerDropModuleList',
    'LayerNorm',
    'LearnedPositionalEmbedding',
    'LightweightConv1dTBC',
    'LightweightConv',
    'LinearizedConvolution',
    'MultiheadAttention',
    'PositionalEmbedding',
    'ScalarBias',
    'SinusoidalPositionalEmbedding',
    'TransformerSentenceEncoderLayer',
    'TransformerSentenceEncoder',
    'TransformerDecoderLayer',
    'TransformerEncoderLayer',
    'PascalTransformerEncoderLayer',
    'VGGBlock',
    'unfold1d',
    'MultiheadPascal',
    'MultiheadTPRAttention',
    'MultiheadTPRPascal',
    'TPRTransformerDecoderLayer',
    'TPRTransformerEncoderLayer',
    'TPRPascalTransformerEncoderLayer'
]
