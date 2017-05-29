
exception Empty
exception Subscript

module type STACK = sig
  type 'a stack
  val empty : 'a stack
  val isEmpty : 'a stack -> bool
  val cons : 'a -> 'a stack -> 'a stack
  val head : 'a stack -> 'a
  val tail : 'a stack -> 'a stack
  val (++) : 'a stack -> 'a stack -> 'a stack
end

module ListStack : STACK = struct
  type 'a stack = 'a list

  let empty = []
  let isEmpty s = s = []

  let cons x s = x :: s
  let head = function
      [] -> raise Empty
    | h :: _ -> h

  let tail = function
      [] -> raise Empty
    | _ :: t -> t

  let (++) = (@)
end

module CustomStack : STACK = struct
  type 'a stack = Nil | Cons of 'a * 'a stack

  let empty = Nil
  let isEmpty s = s = Nil
  let cons x s = Cons(x, s)
  let head = function
      Nil -> raise Empty
    | Cons(h, _) -> h
  let tail = function
      Nil -> raise Empty
    | Cons(_, t) -> t
  let rec (++) xs ys = match xs with
      Nil -> ys
    | Cons(hxs, txs) -> cons hxs (txs ++ ys)
end

