open Core.Std
#load "str.cma"

type sentence = {
  words : string list;
  orig  : string
}

let sentence_regex = Str.regexp "[\\.!?] *\\|\n\n"
let word_regex = Str.regexp "[ \n,]+"
let empty_regex = Str.regexp "^[ \n]*$"

let is_empty (s : string) : bool =
  Str.string_match empty_regex s 0

let rec str_list_to_sentence_list (lst : string list) : sentence list = 
  match lst with 
  | [] -> []
  | hd :: tl ->
     if (not (is_empty hd)) then
       {words = Str.split word_regex hd; orig = hd} :: 
	 str_list_to_sentence_list tl
     else 
       str_list_to_sentence_list tl

let parse (in_stream : In_channel.t) : sentence list =
  let text = In_channel.input_all in_stream in
  str_list_to_sentence_list (Str.split sentence_regex text)
