let () =
  if Array.length Sys.argv < 2 then
    Printf.eprintf "Usage: %s <filename> <ciphertext> <nswaps> <ntrials>\n" Sys.argv.(0)
  else
    let filename = Sys.argv.(1) in
    let ciphertext = Sys.argv.(2) in
    let n_swaps = Sys.argv.(3) |> int_of_string in
    let n_trials = Sys.argv.(4) |> int_of_string in
    let bigram_counts = Bigrams.compute_bigram_frequencies filename in
    let (key,score) =  Cipher.best_score ciphertext bigram_counts n_swaps n_trials in
    let decrypted_cipher = Cipher.encrypt_text key (Bigrams.normalize_text ciphertext) in

    Printf.printf "Best English-ness score: %d\n (with key: %s)\n resulting in translation:\n %s " score key decrypted_cipher
