# QUIPSTER-cipher-solver

An Ocaml implementation of the QUIPSTER Substitution Cipher Solving Algorithm from ["Solving Substitution Ciphers" - Hasinoff (2003)](https://people.csail.mit.edu/hasinoff/pubs/hasinoff-quipster-2003.pdf)

## Example

Attempt to crack [YOUR CIPHERTEXT] with 100 swaps of 1000 trials with a bigram frequency table generated from `data/great-expectations.txt.`

```sh
dune exec ./main.exe data/great-expectations.txt [YOUR CIPHERTEXT] 1000 100
```

## Status

Currently, the starts and ends of lines, ~as well as spaces~, are not included in forming the bigram frequencies - scoring is therefore hampered as it is a quality of some letters that they appear more often at the starts or ends of ~words~ / sentences.

[adding spaces to the bigram table has resulted in a large increase in Englishness score ~ 4x ]

Furthermore, the project is limmited to bigrams - it would be nice to extent this to trigrams / other n-grams, or to recognise words / phrases in the scoring function.

The scoring function is also incomplete: the overall frequency of a phrase is currently computed additively, with zero-probabilities left as they are. The paper made use of smoothing techniques which I would also like to implement.

The training corpus in the example (Dicken's Great Expectations) is relatively small and so bigrams can be computed at runtime - which is what the project does. It would be better to use a (much) larger corpus which would involve saving the frequenies to disk.

~As of now the project cannot viably be used to decrypt substitution ciphers; it has manged however to uncovered some words in longer (>50 characters) ciphertexts within a short runtime: 10-20 seconds.~

It kind of works!

## A very bad example

Using *test data from the training set*: 

> when he came to the low church wall he got over it like a man whose
> legs were numbed and stiff and then turned round to look for me

Encrypted with the key "ekviyjutomscxhdngflqbwpzra" it becomes

> Wtyh ty vexy qd qty cdp vtbfvt pecc ty udq dwyf oq cosy e xeh ptdly 
> cyul pyfy hbxkyi ehi lqojj ehi qtyh qbfhyi fdbhi qd cdds jdf xy

Running 500 trials at 1000 swaps 

```sh
dune exec ./main.exe data/great-expectations.txt [CIPHERTEXT] 1000 500
```

Yields, in 5.925s,

> Best English-ness score: 1337498
>  (with key: zuaoirkndlgyxjbstqfhcwvmep)
> resulting in translation:
> chen he wabe to the som whurwh mass he pot ocer it sile a ban mhofe 
> sepf mere nubved and ftiyy and then turned round to sool yor b 

Running 5000 trials at 1000 swaps

Yields, in 1m0.998s,

> Best English-ness score: 1375978
> (with key: qusoarzndybfjpiwtkghlcvmex)
> resulting in translation:
> vhen he came to the sow church wass he lot over it sige a man whofe 
> self were numbed and ftiyy and then turned round to soog yor m 

Interestingly, the English-ness scores are very similar; however, the seond translation is quite a bit clearer.
