open Core.Std

type sentence = {
  words : string list;
  orig  : string
}

let parse (in_stream : In_channel.t) : sentence list =
  [{words = ["hi"; "bye"]; orig = "hi! bye."}]
