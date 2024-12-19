(*

  cipher.ml

  The Cipher module: ultimately, it provides the function best_score which searches for the best key to decipher a ciphertext.

  To that aim, many functions are exposed...

 *)

(* ------------------------------------------------------------------------------------------ *)

let score_cipher tbl ciphertext =

  let score_bigram tbl bg =     (* look up the frequency of a single bigram *)
    try Hashtbl.find tbl bg with
    | Not_found -> 0
  in
  (* turn the ciphertext into a list of bigrams *)
  let bigrams = Bigrams.string_to_bigrams ciphertext in
  (* assign a score to each bigram *)
  let scores = List.map (fun bg -> score_bigram tbl bg) bigrams in
  (* add the scores together -- will later introduce smoothing to deal with scores of zero *)
  List.fold_left ( + ) 0 scores

(* ------------------------------------------------------------------------------------------ *)

(* turn a key into a hashtable *)
let create_substitution_map key =
  let map = Hashtbl.create 26 in
  let alphabet = "abcdefghijklmnopqrstuvwxyz" in
  String.iteri (fun i c -> Hashtbl.add map c key.[i]) alphabet; (* insert the alphabet into the hash table *)
  map

(* encrypt a single character *)
let encrypt_char map c =
  try Hashtbl.find map c with
  | Not_found -> c (* leave characters outside of map unchanged *)

(* function to encrypt a string *)
let encrypt_text key text =
  let map = create_substitution_map key in
  String.map (encrypt_char map) text

(* ------------------------------------------------------------------------------------------ *)

(* swap two characters in a string at given indices *)
let swap_chars str i j =
  let result = Bytes.of_string str in (* use a byte sequence - a mutable data structure *)
  let temp = Bytes.get result i in
  Bytes.set result i (Bytes.get result j);
  Bytes.set result j temp;
  Bytes.to_string result

(* generate two random indicies and swap characters *)
let mutate_key key =
  let len = String.length key in
  let i = Random.int len in
  let j = Random.int len in
  if i = j then key else swap_chars key i j

(* ------------------------------------------------------------------------------------------ *)

(* create a random permutation of a list *)
let shuffle_list lst =
  let arr = Array.of_list lst in
  let len = Array.length arr in
  for i = len - 1 downto 1 do
    let j = Random.int (i + 1) in
    let temp = arr.(i) in
    arr.(i) <- arr.(j);
    arr.(j) <- temp
  done;
  Array.to_list arr

(* generate a random permutation of the alphabet - a key *)
let create_random_key () =
  let alphabet = List.init 26 (fun i -> Char.chr (i + Char.code 'a')) in
  let lst = shuffle_list alphabet in
  String.of_seq (List.to_seq lst)

(* ------------------------------------------------------------------------------------------ *)

(* recursive search method from the paper *)
let best_score text tbl n_trials n_swaps =
  let rec best_swap n score key =
    if n = 0 then
      (key, score)
    else
      let new_key = mutate_key key in
      let new_score = (score_cipher tbl (encrypt_text new_key text))  in
      if new_score > score then
        best_swap (n - 1) new_score new_key
      else
        best_swap (n - 1) score key
  in

  let rec best_trial n score key =
    if n = 0 then
      (key, score)
    else
      let random_key = create_random_key () in
      let (new_key, new_score) = best_swap n_swaps 0 random_key in
      if new_score > score then
        best_trial (n - 1) new_score new_key
      else
        best_trial (n - 1) score key
  in

  let random_key = create_random_key () in
  let score = 0 in

  best_trial n_trials score random_key      

(* ------------------------------------------------------------------------------------------ *)
