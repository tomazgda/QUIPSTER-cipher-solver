# QUIPSTER-cipher-solver

An Ocaml implementation of the QUIPSTER Substitution Cipher Solving Algorithm from ["Solving Substitution Ciphers" - Hasinoff (2003)](https://people.csail.mit.edu/hasinoff/pubs/hasinoff-quipster-2003.pdf)

## Example

Attempt to crack [YOUR CIPHERTEXT] with 100 swaps of 1000 trials with a bigram frequency table generated from `data/great-expectations.txt.`

```ocaml
dune exec ./main.exe data/great-expectations.txt [YOUR CIPHERTEXT] 1000 100
```

## Status

Currently, the starts and ends of lines, as well as spaces, are not included in forming the bigram frequencies - scoring is therefore hampered as, to take one example, it is a quality of some letters that they appear more often at the starts or ends of words. 

Furthermore, the project is limmited to bigrams - it would be nice to extent this to trigrams / other n-grams, or to recognise words / phrases in the scoring function.

The scoring function is also incomplete: the overall frequency of a phrase is currently computed additively, with zero-probabilities left as they are. The paper made use of smoothing techniques which I would also like to implement.

The training corpus in the example (Dicken's Great Expectations) is relatively small and so bigrams can be computed at runtime - which is what the project does. It would be better to use a (much) larger corpus which would involve saving the frequenies to disk.

As of now the project cannot viably be used to decrypt substitution ciphers; it has manged however to uncovered some words in longer (>50 characters) ciphertexts within a short runtime: ~10-20 seconds.
