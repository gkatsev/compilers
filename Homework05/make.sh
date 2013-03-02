#!/bin/bash

echo "cleaning old compiled files..."
rm test/*.tig.s

echo "Compiling tiger.grm..."
ml-lex tiger.lex
ml-yacc tiger.grm

echo "Running CM..."
sml make.sml
