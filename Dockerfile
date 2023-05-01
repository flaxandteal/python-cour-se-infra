FROM jupyter/scipy-notebook:python-3.10

USER root

# Geo pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cython3 python3-rtree python3-pyproj git curl libproj-dev gdal-bin libgdal-dev libgeos-dev libpq-dev proj-bin plantuml openssh-client build-essential && \
    rm -rf /var/lib/apt/lists/*
RUN pip install cython setuptools k3d
RUN pip install GDAL==$(gdal-config --version) --global-option=build_ext --global-option="-I/usr/include/gdal" 
RUN pip install nbgitpuller bokeh jinja2 matplotlib numpy pandas patsy geocube sklearn sympy watchdog cartopy folium inflect networkx nltk scipy scikit-image statsmodels ipywidgets xlrd quandl geopandas RISE jupyter_contrib_nbextensions hide_code jupyterhub-firstuseauthenticator iplantuml mypy pylint pytest torch dask distributed
RUN jupyter serverextension enable --py nbgitpuller --sys-prefix
RUN jupyter contrib nbextension install --sys-prefix
RUN jupyter nbextension install --py --sys-prefix hide_code
RUN jupyter nbextension enable --py --sys-prefix hide_code
RUN jupyter serverextension enable --py --sys-prefix hide_code

USER $NB_UID
