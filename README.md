## To install:

> git clone https://github.com/StanfordWELab/pyCascade.git
> cd pyCascade
# to install in base python environment
> pip install ./dist/pyCascade-0.1.0-py3-none-any.whl

# to build custom version
# {First time setup) create a virtual environment:
> conda create --name <env> --file requirements.txt
# activate environemnt
> conda activate <env>
> python setup.py bdist_wheel
> conda deactivate

> pip install ./dist/<new_wheel_file>.whl


