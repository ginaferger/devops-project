#!/bin/bash

pip install --no-cache-dir virtualenv
virtualenv .venv
source .venv/bin/activate
pip install --no-cache-dir -r requirements.txt
