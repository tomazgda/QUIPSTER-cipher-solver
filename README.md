# QUIPSTER-cipher-solver

An Ocaml implementation of the QUIPSTER Substitution Cipher Solving Algorithm from ["Solving Substitution Ciphers" - Hasinoff (2003)](https://people.csail.mit.edu/hasinoff/pubs/hasinoff-quipster-2003.pdf)

## Example

Attempt to crack [YOUR CIPHERTEXT] with 100 swaps of 1000 trials with a bigram frequency table generated from `data/great-expectations.txt.`

```ocaml
dune exec ./main.exe data/great-expectations.txt [YOUR CIPHERTEXT] 1000 100
```

## Status

Currently, the starts and ends of lines, as well as spaces, are not included in forming the bigram frequencies - scoring is therefore hampered as, to take one example, it is a quality of some letters that they appear more often at the start or ends of words. 

Commenting on the project as a whole, it has uncovered some words in longer (>50 characters) ciphertexts within a short runtime ~10-20 seconds. However, as of now it cannot viably be used to decrypt substitution ciphers.
