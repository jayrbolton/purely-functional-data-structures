#!/bin/bash

dir_name=$1

rm $dir_name/test
ocamlfind ocamlc -o $dir_name/test -thread -package oUnit -linkpkg -g $dir_name/$dir_name.ml
$dir_name/test


