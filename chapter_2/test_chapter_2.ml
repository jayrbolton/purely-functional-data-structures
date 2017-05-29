open OUnit2

let test1 test_ctxt = assert_equal 1 2

(* Operator ">:::" defines a list of tests *)
(* Operator ">::" names a test *)

let suite =
  "suite" >::: (* define a list of tests *)
    [ "test1" >:: test1
    ]

let () = run_test_tt_main suite
