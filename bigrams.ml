(*

  bigrams.ml

  Provides the Bigrams module, exposing three functions:

  normalize_text : makes a string entirely lowercase, removing non-alphabetic characters

  compute_bigram_frequencies : computes the frequency of bigrams in an input file, returning a (Bigram, Freq) Hashtable

  turn_string_in_bigrams : turns a string into a list of its non-unique bigrams

 *)


(* ------------------------------------------------------------------------------------------ *)

let normalize_text text =
  String.map (fun c ->
    if Char.code 'A' <= Char.code c && Char.code c <= Char.code 'Z' then
      Char.lowercase_ascii c
    else if Char.code 'a' <= Char.code c && Char.code c <= Char.code 'z' then
      c
    else
      ' '                       (* replace non-characters with spaces *)
    ) text

(* ------------------------------------------------------------------------------------------ *)

let compute_bigram_frequencies filename =
  let bigram_counts = Hashtbl.create 729 in (* 27 * 27 possible bigrams *)

  let process_line line =
    let normalized = normalize_text line in
    let len = String.length normalized in
    for i = 0 to len - 2 do
      let ch1 = normalized.[i] in
      let ch2 = normalized.[i + 1] in
      let bigram = String.make 1 ch1 ^ String.make 1 ch2 in
      Hashtbl.replace bigram_counts bigram (1 + (Hashtbl.find_opt bigram_counts bigram |> Option.value ~default:0))
    done
  in

  let ic = open_in filename in
  try
    while true do
      let line = input_line ic in
      process_line line
    done
  with End_of_file -> close_in ic;

  bigram_counts

(* ------------------------------------------------------------------------------------------ *)

let string_to_bigrams str =
  let len = String.length str in
  let rec collect_bigrams i acc =
    if i >= len - 1 then
      List.rev acc
    else
      let bigram = String.sub str i 2 in
      collect_bigrams (i + 1) (bigram :: acc)
  in
  collect_bigrams 0 []

(* ------------------------------------------------------------------------------------------ *)

