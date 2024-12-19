# QUIPSTER-cipher-solver

An Ocaml implementation of the QUIPSTER Substitution Cipher Solving Algorithm from ["Solving Substitution Ciphers" - Hasinoff (2003)](https://people.csail.mit.edu/hasinoff/pubs/hasinoff-quipster-2003.pdf)

## Example

Attempt to crack [YOUR CIPHERTEXT] with 100 swaps of 1000 trials with a bigram frequency table generated from `data/great-expectations.txt.`

```ocaml
dune exec ./main.exe data/great-expectations.txt [YOUR CIPHERTEXT] 1000 100
```

