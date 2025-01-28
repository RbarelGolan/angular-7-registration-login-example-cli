#!/usr/bin/env python3
import argparse
import os
import subprocess

from PIL.PyAccess import mode_map

current_dir = os.path.dirname(os.path.abspath(__file__))
os.chdir(current_dir + '/../')

arg_parser = argparse.ArgumentParser(description='Start the application')
arg_parser.add_argument('--verbose', '-v', action='store_true', help='Enable verbose mode')
arg_parser.add_argument('--install', '-i', action='store_true', help='Install Node Modules')
arg_parser.add_argument('--reset', action='store_true', help='Reset the terminal')
arg_parser.add_argument('--mode', type=str, help='Specify the mode to start the application in')
arg_parser.add_argument('--node', required=False, type=str, help='Specify the node version to use', default='')


def main():
  print("Current Directory:", os.getcwd())
  options = arg_parser.parse_args()
  print('Options:', options)
  if options.reset:
    print('Resetting terminal...')
    os.system('clear')
  if options.install:
    print('Installing Node Modules...')
    os.system('npm install')
  subprocess.run(['bash', '-c', 'source ~/.nvm/nvm.sh && nvm use ' + options.node], check=True)
  start_arguments = ['npm', 'start']
  if options.mode:
    print('Starting application in mode', options.mode)
    start_arguments.append('--')
    start_arguments.append('--mode')
    start_arguments.append(options.mode)
  subprocess.run(start_arguments, check=True)


if __name__ == '__main__':
  main()
