#!/usr/bin/env bash

source ~/.bashrc

conda activate

git pull && conda env update --prefix ../playground_env
