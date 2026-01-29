#!/bin/bash

lower='nulat'
upper='NULAT'
mixed='Nulat'

if [ ! -z $1 ]
then
  basestring=${1,,}
  upstring=${basestring^^}
  mixedstring=${basestring^}

  find . -type f -not -path "./.git/*" -exec sed -i "s/${lower}/${basestring}/g" {} \;
  find . -type f -not -path "./.git/*" -exec sed -i "s/${upper}/${upstring}/g" {} \;
  find . -type f -not -path "./.git/*" -exec sed -i "s/${mixed}/${mixedstring}/g" {} \;
  mv config/${lower}.sh.in config/${basestring}.sh.in
  mv src/${lower}.cpp src/${basestring}.cpp
  mv src/${mixed}.cc src/${mixedstring}.cc
  mv src/include/${mixed}.hh src/include/${mixedstring}.hh
fi
