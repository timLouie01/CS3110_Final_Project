open OUnit2
open Zero_Degrees

let pretty_string s = "\"" ^ s ^ "\""
let pretty_int n = "\"" ^ string_of_int n ^ "\""
let pretty_bool b = "\"" ^ string_of_bool b ^ "\""

module X = Zero_Degrees.Ship.AShip
let samplecarrier = Zero_Degrees.Ship.AShip.build_ship "Carrier" 
let samplebattleship = Zero_Degrees.Ship.AShip.build_ship "Battleship" 
let sampledestroyer = Zero_Degrees.Ship.AShip.build_ship "Destroyer" 
let samplesub = Zero_Degrees.Ship.AShip.build_ship "Submarine" 
let samplepb = Zero_Degrees.Ship.AShip.build_ship "Patrol Boat" 


(* Functions that create a 10x10 list, as returned by set_position *)
(* let rec range min max =
  if min > max then [] else min :: range (min + 1) max 

let pblist = let range = range 0 9 in
  List.concat (List.map (fun x -> List.map (fun y -> (x, y)) range) range) *)

let pbaddbool x = 
  match x with 
  | (a,b) -> if (a=0 && b=0) || (a=0 && b=1) then ((a,b), false) 
      else ((a,b), true)

let ship_tests = [
  ("get_health carrier" >:: fun _ -> 
    assert_equal ~printer:(pretty_int) (5) (X.get_health samplecarrier));
  ("get_length carrier" >:: fun _ -> 
    assert_equal ~printer:(pretty_int) (5) (X.get_length samplecarrier));
  ("get_type_of_ship carrier" >:: fun _ -> 
    assert_equal ~printer:(pretty_string) ("Carrier") 
      (X.get_type_of_ship samplecarrier));
  ("get_hits carrier" >:: fun _ -> 
    assert_equal ~printer:(pretty_int) (0) (X.get_hits samplecarrier));
  ("get_sunk carrier" >:: fun _ -> 
    assert_equal ~printer:(pretty_bool) (false) (X.get_sunk samplecarrier)); 
  (* ("set_position carrier" >:: fun _ -> assert_equal 
      (List.map (pbaddbool) pblist) (X.set_position smallsampleship 0 0 0 1)); *)
  (* ("hit_ship carrier" >:: fun _ -> 
    assert_equal (0) (X.hit_ship sampleship (0,0))); *)

  ("get_health battleship" >:: fun _ -> 
    assert_equal ~printer:(pretty_int) (4) (X.get_health samplebattleship));
  ("get_length battleship" >:: fun _ -> 
    assert_equal ~printer:(pretty_int) (4) (X.get_length samplebattleship));
  ("get_type_of_ship battleship" >:: fun _ -> 
    assert_equal ~printer:(pretty_string) ("Battleship") 
      (X.get_type_of_ship samplebattleship));
  ("get_hits battleship" >:: fun _ -> 
    assert_equal ~printer:(pretty_int) (0) (X.get_hits samplebattleship));
  ("get_sunk battleship" >:: fun _ -> 
    assert_equal ~printer:(pretty_bool) (false) (X.get_sunk samplebattleship)); 

  ("get_health patrol boat" >:: fun _ -> 
    assert_equal ~printer:(pretty_int) (2) (X.get_health samplepb));
  ("get_length patrol boat" >:: fun _ -> 
    assert_equal ~printer:(pretty_int) (2) (X.get_length samplepb));
  ("get_type_of_ship patrol boat" >:: fun _ -> 
    assert_equal ~printer:(pretty_string) 
    ("Patrol Boat") (X.get_type_of_ship samplepb));
  ("get_hits patrol boat" >:: fun _ -> 
    assert_equal ~printer:(pretty_int) (0) (X.get_hits samplepb));
  ("get_sunk patrol boat" >:: fun _ -> 
    assert_equal ~printer:(pretty_bool) (false) (X.get_sunk samplepb)); ]

module SB = Zero_Degrees.ShipsBag.PlayerList
let samplebag= SB.build_bag 0
let sample_healthlist = 
  "+ Carrier Ship Health 5 of 5
  + Battleship Ship Health 4 of 4
  + Destroyer Ship Health 3 of 3
  + Submarine Ship Health 3 of 3
  + Patrol Boat Ship Health 2 of 2" 
let sink_all = []

let ships_bag_tests = [
  ("bag get_carrier" >:: fun _ -> 
    assert_equal (X.build_ship("Carrier")) (SB.get_Carrier samplebag));
  ("bag get_battleship" >:: fun _ -> 
    assert_equal (X.build_ship("Battleship")) (SB.get_Battleship samplebag));
  ("bag get_destroyer" >:: fun _ -> 
    assert_equal (X.build_ship("Destroyer")) (SB.get_Destroyer samplebag));
  ("bag get_submarine" >:: fun _ -> 
    assert_equal (X.build_ship("Submarine")) (SB.get_Submarine samplebag));
  ("bag get_patrolboat" >:: fun _ -> 
    assert_equal (X.build_ship("Patrol Boat")) (SB.get_patrolBoat samplebag));
  ("bag list_health" >:: fun _ -> 
    assert_equal (print_endline sample_healthlist) (SB.list_health samplebag));
] 
let board_tests = [] 

let suite = "suite" >::: 
  List.flatten [ship_tests; board_tests; ships_bag_tests;]

let () = run_test_tt_main suite