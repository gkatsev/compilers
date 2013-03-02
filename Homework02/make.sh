#!/bin/bash

echo "Compiling tiger.grm..."
ml-lex tiger.lex
ml-yacc tiger.grm

echo "Running CM..."
sml make.sml
