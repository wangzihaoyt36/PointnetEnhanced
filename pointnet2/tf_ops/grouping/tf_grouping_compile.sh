#/bin/bash
/usr/local/cuda-10.1/bin/nvcc tf_grouping_g.cu -o tf_grouping_g.cu.o -c -O2 -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC

TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')
CUDA_INC='/usr/local/cuda-10.1/include'
CUDA_LIB='/usr/local/cuda-10.1/lib64/'

g++ -std=c++11 tf_grouping.cpp tf_grouping_g.cu.o -o tf_grouping_so.so -shared -fPIC -I $TF_INC -I $CUDA_INC -I $TF_INC/external/nsync/public -lcudart -L $CUDA_LIB -L$TF_LIB -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0
