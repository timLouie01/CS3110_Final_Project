open OUnit2
open Zero_Degrees

module X = Zero_Degrees.Ship.AShip
let sampleship = Zero_Degrees.Ship.AShip.build_ship "Carrier" 

let tests = [
  (* ship tests *)
  ("get_health carrier" >:: fun _ -> 
    assert_equal (5) (X.get_health sampleship));
  ("get_length carrier" >:: fun _ -> 
    assert_equal (5) (X.get_length sampleship));
  ("get_type_of_ship carrier" >:: fun _ -> 
    assert_equal ("Carrier") (X.get_type_of_ship sampleship));
  ("get_hits carrier" >:: fun _ -> 
    assert_equal (0) (X.get_hits sampleship));
  (* ("get_hits carrier" >:: fun _ -> assert_equal 
    [((0,0), false); ((0,1),false); ((0,2),false); ((0,3),false); ((0,4),false)] 
      (X.set_position sampleship 0 0 0 5)); *)
]

let suite = "suite" >::: tests
let () = run_test_tt_main suite