# Getting started

## Set up environment

1. Go to the Sagemaker console / Notebook Instance. You should probably pick Ohio region. 

   https://us-east-2.console.aws.amazon.com/sagemaker/home?region=us-east-2#/notebook-instances

1. Create a new notebook. 
   1. Disable root access.
   1. For encryption key, choose the only key with jupyter in the name.
   1. For the role, choose one that looks like AmazonSageMaker-ExecutionRole or let AWS make one.
   1. Leave all other settings as default.
   1. After creating, wait for the notebook to come online.

1. Start the notebook by clicking "Open Jupyter" next to it. Do not use JupyterLab for now.
   (The reason to avoid JupyterLab is that installing widgets can raise some mysterious errors.
   You can try JupyterLab later if you want though, it seems to work despite the errors.
   Another reason to use normal Jupyter is that it has a quit button which presumably logs
   out of your session, where as JupyterLab does not have that AFAIK.)

1. Open a Terminal from the `New` menu in the top right. Then run `bash` for a better shell.

1. In order to use git credentials with AWS Secrets Manager, run:
   ~~~bash
   cd ~/SageMaker
   repo_name=aws-secrets-manager-git-credential-helper
   executable_path=~/SageMaker/aws-secrets-manager-git-credential-helper/secretsmanager-git-credential-helper.py

   [[ -d $repo_name ]] || git clone https://github.com/zuoralabs/$repo_name

   
   git config --global credential.https://git.service.helper "! $executable_path https://git.service"
   git config --global aws-secrets-manager.https://git.service.region-name "us-west-2"
   git config --global aws-secrets-manager.https://git.service.secret-id "security/service_accounts/github_enterprise"
   ~~~

1. Clone this repo.

1. Install the new kernel. Run 
   ~~~bash
   ./setup-conda-on-notebook-instance.sh
   ./setup-ipywidgets-and-ipysheets-for-notebook-instance.sh
   ~~~
   *NOTE 1*: When you want to update, run `update-conda-on-notebook-instance.sh`.
   
   *NOTE 2*: Optionally, you can run `./setup-ipywidgets-and-ipysheets.sh`
   with the flag `--with-jupyter-lab-support` if widgets in JupyterLab are desired. This is unreliable
   and can take a while to install, so it is left as an option.

1. Now you can choose the new `conda_playground` kernel when running a notebook.
   (Kernel menu -> Change kernel ...) 


## Try some examples

Try out `widgets-examples.ipynb`.
For bug management, always choose `conda_playground` kernel when asked.
Press `shift-enter` to run a cell.


## Troubleshooting

*Problem*: `ipysheet` widgets do not work 

*Solution*: Try running:
~~~
~/anaconda3/envs/JupyterSystemEnv/bin/jupyter nbextension enable --py --sys-prefix ipysheet
~~~
This is not part of the standard installation process because ipysheet docs say it should be unnecessary
for newer versions of jupyter.


## Notes

The conda version in new notebook-instances as of 5/5/2020 is too old for
`conda init`, and I haven't found a way to activate envs successfully.
`conda activate` will make a misleading UI change but it won't actually
activate anything.

The trick with getting jupyter widgets to work is that it needs to be installed
in the JupyterSystemEnv, because that is where the notebook instance runs the
jupyter executable from. Jupyter attaches to the selected kernel which does the
processing, but the UI logic is handled in the environment where Jupyter lives
(JupyterSystemEnv).


## Widgets

To install matplotlib widgets, run
~~~
jupyter=~/anaconda3/envs/JupyterSystemEnv/bin/jupyter
$jupyter nbextension install --py --symlink --sys-prefix ipympl
$jupyter nbextension enable --py --sys-prefix ipympl
$jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-matplotlib
~~~
