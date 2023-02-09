FROM ucsdets/scipy-ml-notebook:2023.1-stable
LABEL maintainer="Javier Duarte <jduarte@ucsd.edu>"

USER root

RUN apt-get update && \
    apt-get install -y imagemagick && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER jovyan

RUN pip install --no-cache-dir 'xgboost==1.7.3' 'scikit-learn==1.2.1' 'spektral==1.2.0' 'gdown==4.6.0' && \
    fix-permissions /opt/conda && \
    fix-permissions /home/jovyan

USER $NB_UID:$NB_GID
RUN mkdir -p /tmp/nvvm && mkdir -p /tmp/nvvm/libdevice && cp /opt/conda/lib/libdevice.10.bc /tmp/nvvm/libdevice/
ENV XLA_FLAGS="--xla_gpu_cuda_data_dir=/tmp"
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/conda/lib
ENV PATH=${PATH}:/usr/local/nvidia/bin:/opt/conda/bin:/datasets/software/R2019a/sys/cuda/glnxa64/cuda/bin
