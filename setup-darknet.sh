#!/usr/bin/env bash
set -e

DARKNET_ENABLE_GPU=$0

git clone https://github.com/AlexeyAB/darknet.git
cd darknet
git stash
# Taking commit from 10 July 2020
# git checkout aa002ea1f8fbce6e139210ee1d936ce58ce120e1

sed -i -e 's/OPENCV=0/OPENCV=1/' Makefile && sed -i -e 's/LIBSO=0/LIBSO=1/' Makefile
if [[ $DARKNET_ENABLE_GPU == 1 ]]; then 
    sed -i -e 's/GPU=0/GPU=1/' Makefile
    sed -i -e 's/CUDNN=0/CUDNN=1/' Makefile
    sed -i -e 's/CUDNN_HALF=0/CUDNN_HALF=1/' Makefile

    make
    echo "Compiled for GPU"
else
    make
    echo "Compiled for CPU"
fi 

cd ..
