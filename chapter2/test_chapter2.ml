open OUnit2
open Chapter2

let test1 test_ctxt = assert_equal Chapter2.ListStack.empty []

(* Operator ">:::" defines a list of tests *)
(* Operator ">::" names a test *)

let suite =
  "suite" >:::
    [ "test1" >:: test1
    ]

let () = run_test_tt_main suite
