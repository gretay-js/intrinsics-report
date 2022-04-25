open OUnit2
open Ocaml_intrinsics.Int

let pp msg n =
  Printf.printf "%s: %d\n" msg n;
  n

(*
 fails on github ci and old macs (e.g. macbook air from 2012, with Intel Core i5-3317U CPU0
 with first release of ocaml_intrinsics which incorrectly passes -mbmi and -mlzcnt
 to c compiler, even though they aren't available on the target,
 and the c compiler generates BEXTR and LZCNT instructions for int_stubs. 
 *) 
let suite = "Intrinsics tests" >::: [
  "clz"     >:: (fun _ -> assert_equal 28 (count_leading_zeros 0x400000000 |> pp "clz"));
  "clz2"    >:: (fun _ -> assert_equal 28 (count_leading_zeros2 0x400000000 |> pp "clz2"));
  "ctz"     >:: (fun _ -> assert_equal 34 (count_trailing_zeros 0x400000000 |> pp "ctz"));
  "popcnt"  >:: (fun _ -> assert_equal 24 (count_set_bits 0xdeadbeef |> pp "popcnt"));
  "popcnt2" >:: (fun _ -> assert_equal 24 (count_set_bits2 0xdeadbeef |> pp "popcnt2"));
]

let _ = run_test_tt_main suite
