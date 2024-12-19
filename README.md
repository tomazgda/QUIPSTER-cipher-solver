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

## Very bad examples

...because the test data is from the training set.

### A short one 

> when he came to the low church wall he got over it like a man whose
> legs were numbed and stiff and then turned round to look for me

Encrypted with the key "ekviyjutomscxhdngflqbwpzra" it becomes

> Wtyh ty vexy qd qty cdp vtbfvt pecc ty udq dwyf oq cosy e xeh ptdly 
> cyul pyfy hbxkyi ehi lqojj ehi qtyh qbfhyi fdbhi qd cdds jdf xy

Running 500 trials at 1000 swaps ->

```sh
dune exec ./main.exe data/great-expectations.txt [CIPHERTEXT] 1000 500
```

> chen he wabe to the som whurwh mass he pot ocer it sile a ban mhofe sepf mere nubved and ftiyy and then turned round to sool yor b 

**In 5.925s**

(with key: zuaoirkndlgyxjbstqfhcwvmep)

Running 5000 trials at 1000 swaps ->

> vhen he came to the sow church wass he lot over it sige a man whofe self were numbed and ftiyy and then turned round to soog yor m 

**In 1m0.998s.**

(with key: qusoarzndybfjpiwtkghlcvmex)

### A longer one

> when he came to the low church wall he got over it like a man whose legs were numbed and stiff and then turned round to look for me when I saw him turning I set my face towards home and made the best use of my legs But presently I looked over my shoulder and saw him going on again towards the river still hugging himself in both arms and picking his way with his sore feet among the great stones dropped into the marshes here and there for stepping places when the rains were heavy or the tide was in

Encrypted with key "zyxwvutsrqponmlkjihgfedcba"

> dsvm sv xznv gl gsv old xsfixs dzoo sv tlg levi rg orpv z nzm dslhv ovth dviv mfnyvw zmw hgruu zmw gsvm gfimvw ilfmw gl ollp uli nv dsvm R hzd srn gfimrmt R hvg nb uzxv gldziwh slnv zmw nzwv gsv yvhg fhv lu nb ovth Yfg kivhvmgob R ollpvw levi nb hslfowvi zmw hzd srn tlrmt lm ztzrm gldziwh gsv irevi hgroo sfttrmt srnhvou rm ylgs zinh zmw krxprmt srh dzb drgs srh hliv uvvg znlmt gsv tivzg hglmvh wilkkvw rmgl gsv nzihsvh sviv zmw gsviv uli hgvkkrmt kozxvh dsvm gsv izrmh dviv svzeb li gsv grwv dzh rm

Running 500 trails at 1000 swaps ->

>  when he came to the low church wall he got ober it like a man whose legs were numved and stiff and then turned round to look for me when i saw him turning i set my face towards home and made the vest use of my legs vut presently i looked ober my shoulder and saw him going on again towards the riber still hugging himself in voth arms and picking his way with his sore feet among the great stones dropped into the marshes here and there for stepping places when the rains were heaby or the tide was in 

**In 22.356s**

(with key: zyxwbutsrqponmlkjihgfedcva)


