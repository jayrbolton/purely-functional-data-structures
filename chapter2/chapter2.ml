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
  let rec (++) xs ys = match xs with
      [] -> ys
    | x :: txs -> x :: (txs ++ ys)
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
    | Cons(x, txs) -> cons x (txs ++ ys)
end

(* update list xs with value y at index i *)
let rec update xs i y = match xs, i with
    [], _ -> raise Subscript
  | (x :: txs), 0 -> y :: xs
  | (x :: txs), _ -> update txs (i - 1) y

(* Exercise 2.1 *)
let rec suffixes xs = match xs with
    [] -> [[]]
  | _ :: txs -> xs :: (suffixes txs)

open OUnit2

open ListStack
let test1 test_ctxt = assert_equal (isEmpty empty) (true)
let test2 test_ctxt = assert_equal (head (cons 1 empty)) 1
let test3 test_ctxt = assert_equal (tail (cons 1 empty)) empty
let test4 test_ctxt = assert_equal ((cons 1 empty) ++ (cons 2 empty)) (cons 1 (cons 2 empty))

open CustomStack
(* TODO write tests for isEmpty, head, tail, cons, ++ for CustomStack *)

(* Exercise 2.1 *)
let test_suffixes test_ctx = assert_equal (suffixes [1;2;3;4]) [[1;2;3;4]; [2;3;4]; [3;4]; [4]; []]

(* Operator ">:::" defines a list of tests *)
(* Operator ">::" names a test *)

let suite =
  "suite" >:::
    [ "ListStack test1" >:: test1
    ; "ListStack test2" >:: test2
    ; "ListStack test3" >:: test3
    ; "ListStack test4" >:: test4
    ; "test_suffixes" >:: test_suffixes
    ]

let () = run_test_tt_main suite
