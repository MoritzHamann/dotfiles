#!/usr/bin/env python3

import logging
import os
import subprocess
import shutil

logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)s: %(message)s')
logger = logging.getLogger(__name__)

HOME = os.environ['HOME']
PWD = os.path.abspath(os.path.dirname(__file__))

class InstallException(Exception):
    pass

folders_to_stow = [
    'nvim',
    'bin',
    'personal',
    'bloomberg'
]


def download_nvim(arch: str, override):
    install_dir = f'{HOME}/nvim_install'
    download_url_mac = "https://github.com/neovim/neovim/releases/download/stable/nvim-macos.tar.gz"
    download_url_linux = "https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"

    # make sure the directory does not exist
    if os.path.exists(install_dir):
        logger.info('nvim_install directory already exists')
        if override:
            shutil.rmtree(install_dir)
            os.mkdir(install_dir)
    else:
        os.mkdir(install_dir)

    # download nvim
    download_url = download_url_mac
    if arch == "linux":
        download_url = download_url_linux
    os.system(f'curl -L {download_url} | tar xz -C {install_dir}')

    # symlink the executable
    if arch == "mac":
        os.system(f'ln -s {install_dir}/nvim-macos/bin/nvim {HOME}/.local/bin')
    elif arch == "linux":
        os.system(f'ln -s {install_dir}/nvim-linux64/bin/nvim {HOME}./local/bin')


def stow_folders(folders: list):
    for folder in folders:
        subprocess.run(['stow', '--target', HOME, folder], cwd=PWD)


def check_dependencies():
    tools = ['stow', 'curl', 'rg'] 

    logger.info('checking dependencies')
    for tool in tools:
        logger.info(f'\t- {tool}')
        result = subprocess.run(['which', tool], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if result.returncode != 0:
            raise InstallException(f'{tool} is not installed')

def install():
    check_dependencies()
    #download_nvim('mac', False)
    stow_folders(folders_to_stow)

if __name__ == '__main__':
    try:
        install()
    except InstallException as e:
        logger.error(e)
    except Exception as e:
        logger.error(e, exc_info=True)
