open Core.Std

type algorithm = TextRank

let get_input_stream (in_filename : string) : In_channel.t =
  In_channel.create in_filename 

let get_output_stream (out_filename : string) : Out_channel.t =
  Out_channel.create out_filename

module T = TextRank.Make(SimpleCompare)

let get_summary (algo : algorithm) (in_stream : In_channel.t) : string list =
  match algo with 
  | TextRank -> 
    T.get_summary (Parser.parse in_stream)

(*
let get_keywords (in_stream : In_channel.t) : string list =
  module K : KEYWORDS = TextRank.make (Parser.parse in_stream)
  K.get_keywords ()   
 *)

let output_summary (algo : algorithm) (in_filename : string) (out_filename : string) =
  let out_stream = Out_channel.create out_filename in 
  Out_channel.output_string out_stream "Test output\n" 
;;

let rec list_to_string (lst : string list) = 
  match lst with 
  | [] -> ""
  | hd :: tl -> hd ^ list_to_string tl

let print_summary (algo : algorithm) (in_filename : string) =
  print_string (list_to_string (get_summary algo (get_input_stream in_filename)))

let command =
  Command.basic
    ~summary:"Summarizer51 is a command line utility to generate summaries of files"
    ~readme:(fun () -> "More info goes here")
    Command.Spec.(
      empty
      +> flag "-a" (optional_with_default "textrank" string) ~doc:"string Name of algorithm to use"
      +> anon ("filename" %: file)
      +> flag "-o" (optional string) ~doc:"string Name of output file"
    )
    (fun algorithm_name in_filename output () -> 
     let algorithm = 
       match String.lowercase algorithm_name with
       | "textrank" -> TextRank 
       | _ -> failwith "Please enter in a supported algorithm"
     in
     match output with 
     | Some out_filename -> output_summary algorithm in_filename out_filename
     | None -> print_summary algorithm in_filename
    )
;;
  
let () =
  Command.run ~version:"0.1" command
