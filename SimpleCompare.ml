type t = string

let compare (s1 : string) (s2 : string) : float =
  if (s1 = s2) then 1. else 0.
