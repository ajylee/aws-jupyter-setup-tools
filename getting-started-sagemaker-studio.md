# Getting started

## Set up environment

1. Go to the SageMaker console in ohio. 

   https://us-east-2.console.aws.amazon.com/sagemaker/home?region=us-east-2

1. If you don't see your name, add a user. Click `Open Studio` next to your user.

1. Clone this repo into the studio.

1. Start kernel installation environment. We need a container in which to install a custom kernel environment.
   1. Choose "Python 3 (Data Science)" when it asks which kernel to use.
      Wait for the kernel to start.

1. Install the new kernel.
   1. Follow the instructions in the notebook. If you are using an image kernel, run `bash setup-conda.sh` from the `install` directory.
   1. Now you can choose the new `playground` kernel when running a notebook. 
      (Kernel menu -> Change kernel ...) There may be multiple kernels listed, one
      for each active container. If there are multiple `playground` kernels, choose the one that refers to Data Science.

1. Install UI extensions.
   1. Run `jupyter labextension install @jupyter-widgets/jupyterlab-manager`
   1. Run `jupyter labextension install ipysheet`
   1. Refresh page to be able to see widgets.


## How to open an image terminal (optional)

Studios run notebooks using kernels that are
installed in "images". We can use the image terminal to install a new kernel.
To open an image terminal:

1. Open any notebook.
1. Choose "Python 3 (Data Science)" when it asks which kernel to use.
   (Use should actually be able to use any kernel, but I haven't tested them.)
   Wait for the kernel to start.
1. Open an image terminal. In the tool bar, there should be a button that is
   square with `$_` in it. The tool tip should say "Launch Terminal in current
   SageMaker Image". If this button is disabled, wait until the kernel starts
   then you can click it.


## Troubleshooting

---
*Problem:*
I tried to start the `playground` kernel but it died straight away.  

*Solution:*
First start the Data Science kernel. That will start a container environment.
Then change the kernel to `playground`. This problem happens because AWS won't start a container for our kernel, so we
piggyback on one of their official kernels.


---
*Problem:*
I tried to start the `playground` Data Science kernel but it only has the
one for base python.

*Solution:*
Start the normal Data Science kernel. Then try to open the `playground` Data Science kernel.
If that fails, try starting an image terminal (see above) and run
~~~
cat ~/.local/share/jupyter/kernels/playground/kernel.json
~~~
Then try again.

This happens because you restarted the Data Science container, but it somehow didn't
load all of the filesystem.



## Notes

- The Data Science environment is suitable for installing a custom kernel because it has the conda command available.
- Although you could try installing the custom kernel in the container conda's system environment, when the container is shut down, 
  the installation will be lost.
