open OUnit2
open Ocaml_intrinsics.Int

let pp msg n =
  Printf.printf "%s: %d\n" msg n;
  n

let suite = "Intrinsics tests" >::: [
  "clz"     >:: (fun _ -> assert_equal 28 (count_leading_zeros 0x400000000 |> pp "clz"));
  "clz2"    >:: (fun _ -> assert_equal 28 (count_leading_zeros2 0x400000000 |> pp "clz2"));
  "ctz"     >:: (fun _ -> assert_equal 34 (count_trailing_zeros 0x400000000 |> pp "ctz"));
  "popcnt"  >:: (fun _ -> assert_equal 24 (count_set_bits 0xdeadbeef |> pp "popcnt"));
  "popcnt2" >:: (fun _ -> assert_equal 24 (count_set_bits2 0xdeadbeef |> pp "popcnt2"));
]

let _ = run_test_tt_main suite
