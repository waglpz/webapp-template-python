#!/usr/bin/env bash

echo Init virtual environment then activating
. $VIRTUAL_ENV/bin/activate activate     \
  && pip install pipenv                       \
  && pipenv install                             
echo virtual environment ist activated
