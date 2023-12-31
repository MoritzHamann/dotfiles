#!/usr/bin/env python3

import logging
import os
import subprocess
import shutil
import argparse

logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)s: %(message)s')
logger = logging.getLogger(__name__)

HOME = os.environ['HOME']
PWD = os.path.abspath(os.path.dirname(__file__))

class InstallException(Exception):
    pass

def download_nvim(arch: str, override):
    install_dir = f'{PWD}/nvim_install'
    download_url_mac = "https://github.com/neovim/neovim/releases/download/stable/nvim-macos.tar.gz"
    download_url_linux = "https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"
    
    # if install exists and we do not force an override, exit nvim install
    if os.path.exists(install_dir) and args.force != True:
        logger.info('nvim_install directory already exists')
        return

    # make sure the directory does not exist
    if os.path.exists(install_dir):
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
    command = []
    if arch == "mac":
        command = ['stow', '-t', f"{HOME}/.local/bin", '-d', f"{install_dir}/nvim-macos/", "bin"]
    elif arch == "linux":
        command = ['stow', '-t', f"{HOME}/.local/bin", '-d', f"{install_dir}/nvim-linux64/", "bin"]

    logger.info(f"running `{' '.join(command)}`")
    subprocess.run(command, cwd=PWD)


def link_folders_via_stow(dotfile_folders: list):
    for main_folder in dotfile_folders:
        stow_folder = os.path.join(main_folder, 'stow')
        for item in os.listdir(stow_folder):
            command = ['stow', '-t', HOME, '-d', stow_folder, item]
            logger.info(f"running `{' '.join(command)}`")
            subprocess.run(command, cwd=PWD)

def check_dependencies():
    tools = ['stow', 'curl', 'rg'] 

    logger.info('checking dependencies')
    for tool in tools:
        logger.info(f'\t- {tool}')
        result = subprocess.run(['which', tool], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        if result.returncode != 0:
            raise InstallException(f'{tool} is not installed')


def ensure_home_folder_setup():
    folders_to_create = [
        ".local",
        os.path.join(".local", "bin"),
        ".config",
        os.path.join(".config", "emacs"),
        os.path.join(".config", "nvim")
    ]

    for folder in folders_to_create:
        full_path = os.path.join(HOME, folder)
        if os.path.isdir(full_path):
            logger.info(f"{folder} exists")
        else:
            logger.info(f"{folder} does NOT exist")
            logger.info(f"=> Creating {folder}")
            os.mkdir(full_path)



def install(args):
    check_dependencies()
    ensure_home_folder_setup()
    download_nvim(args.arch, args.force)

    dotfile_folders = [PWD]
    dotfile_folders.extend(args.dotfiles)
    link_folders_via_stow(dotfile_folders)


def parse_args():
    parser = argparse.ArgumentParser("install.py")
    parser.add_argument("-a", "--arch", action='store', choices=['mac', 'linux'], required=True)
    parser.add_argument("-f", "--force", action='store_true', default=False)
    parser.add_argument('dotfiles', nargs='*', default=[], help='Relative paths to additional dotfiles folders, containing a `stow` folder')
    return parser.parse_args()


if __name__ == '__main__':
    try:
        args = parse_args()
        install(args)
    except InstallException as e:
        logger.error(e)
    except Exception as e:
        logger.error(e, exc_info=True)
