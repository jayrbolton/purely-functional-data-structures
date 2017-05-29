#!/bin/bash

dir_name=$1

ocamlfind ocamlc -o $dir_name/test -package oUnit -linkpkg -g $dir_name/$dir_name.ml $dir_name/test_$dir_name.ml
$dir_name/test


