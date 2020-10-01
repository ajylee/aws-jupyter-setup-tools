#!/usr/bin/env bash

# setup bashrc
conda init bash

source ~/.bashrc


# Create the new kernel environment.
# It needs to be in the home directory so that it gets shared to the containers where 
# the working environments live.
conda env update --prefix ../playground_env

# Activate environment to install stuff to it.
conda activate ../playground_env

# Install the environment as a jupyter kernel.
python -m ipykernel install --user --name playground
