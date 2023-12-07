open OUnit2
open Zero_Degrees

module X = Zero_Degrees.Ship.AShip
let sampleship = Zero_Degrees.Ship.AShip.build_ship "Carrier" 
let smallsampleship = Zero_Degrees.Ship.AShip.build_ship "Patrol Boat" 

(* Functions that create a 10x10 list, as returned by set_position *)
(* let rec range min max =
  if min > max then [] else min :: range (min + 1) max 

let pblist = let range = range 0 9 in
  List.concat (List.map (fun x -> List.map (fun y -> (x, y)) range) range) *)

let pbaddbool x = 
  match x with 
  | (a,b) -> if (a=0 && b=0) || (a=0 && b=1) then ((a,b), true) 
      else ((a,b), false)

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
  (* ("set_position carrier" >:: fun _ -> assert_equal 
      (List.map (pbaddbool) pblist) (X.set_position smallsampleship 0 0 0 1)); *)
  ("get_sunk carrier" >:: fun _ -> 
    assert_equal (false) (X.get_sunk sampleship)); 
  (* ("hit_ship carrier" >:: fun _ -> 
    assert_equal (0) (X.hit_ship sampleship (0,0))); *)
]

let suite = "suite" >::: tests
let () = run_test_tt_main suite