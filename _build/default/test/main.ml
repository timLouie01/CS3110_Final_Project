open OUnit2
open Zero_Degrees

let pretty_string s = "\"" ^ s ^ "\""
let pretty_int n = "\"" ^ string_of_int n ^ "\""
let pretty_bool b = "\"" ^ string_of_bool b ^ "\""

module X = Zero_Degrees.Ship.AShip
let samplecarrier = X.build_ship "Carrier"
let samplebattleship = X.build_ship "Battleship"
let sampledestroyer = X.build_ship "Destroyer"
let samplesub = X.build_ship "Submarine"
let samplepb = X.build_ship "Patrol Boat"
let samplepb2 = X.build_ship "Patrol Boat"
let setpb = X.set_position samplepb2 0 0 1 0
let healthpb = X.hit_ship samplepb2 (0, 0)
let healthpb2 = X.hit_ship samplepb2 (1, 0)

(* Functions that create a 10x10 list, as returned by set_position *)
(* let rec range min max = if min > max then [] else min :: range (min + 1) max

let pblist = let range = range 0 9 in List.concat (List.map (fun x ->
List.map (fun y -> (x, y)) range) range) *)

let pbaddbool x =
  match x with
  | a, b ->
      if (a = 0 && b = 0) || (a = 0 && b = 1) then ((a, b), false)
      else ((a, b), true)

let ship_tests =
  [
    ( "get_health carrier" >:: fun _ ->
      assert_equal ~printer:pretty_int 5 (X.get_health samplecarrier) );
    ( "get_length carrier" >:: fun _ ->
      assert_equal ~printer:pretty_int 5 (X.get_length samplecarrier) );
    ( "get_type_of_ship carrier" >:: fun _ ->
      assert_equal ~printer:pretty_string "Carrier"
        (X.get_type_of_ship samplecarrier) );
    ( "get_hits carrier" >:: fun _ ->
      assert_equal ~printer:pretty_int 0 (X.get_hits samplecarrier) );
    ( "get_sunk carrier" >:: fun _ ->

      assert_equal ~printer:pretty_bool false (X.get_sunk samplecarrier) );
    ( "get_health battleship" >:: fun _ ->
      assert_equal ~printer:pretty_int 4 (X.get_health samplebattleship) );
    ( "get_length battleship" >:: fun _ ->
      assert_equal ~printer:pretty_int 4 (X.get_length samplebattleship) );
    ( "get_type_of_ship battleship" >:: fun _ ->
      assert_equal ~printer:pretty_string "Battleship"
        (X.get_type_of_ship samplebattleship) );
    ( "get_hits battleship" >:: fun _ ->
      assert_equal ~printer:pretty_int 0 (X.get_hits samplebattleship) );
    ( "get_sunk battleship" >:: fun _ ->

      assert_equal ~printer:pretty_bool false (X.get_sunk samplebattleship) );
    ( "get_health destroyer" >:: fun _ ->
      assert_equal ~printer:pretty_int 3 (X.get_health sampledestroyer) );
    ( "get_length destroyer" >:: fun _ ->
      assert_equal ~printer:pretty_int 3 (X.get_length sampledestroyer) );
    ( "get_type_of_ship destroyer" >:: fun _ ->
      assert_equal ~printer:pretty_string "Destroyer"
        (X.get_type_of_ship sampledestroyer) );
    ( "get_hits destroyer" >:: fun _ ->
      assert_equal ~printer:pretty_int 0 (X.get_hits sampledestroyer) );
    ( "get_sunk destroyer" >:: fun _ ->
      assert_equal ~printer:pretty_bool false (X.get_sunk sampledestroyer) );

    ( "get_health submarine" >:: fun _ ->
      assert_equal ~printer:pretty_int 3 (X.get_health samplesub) );
    ( "get_length submarine" >:: fun _ ->
      assert_equal ~printer:pretty_int 3 (X.get_length samplesub) );
    ( "get_type_of_ship submarine" >:: fun _ ->
      assert_equal ~printer:pretty_string "Submarine"
        (X.get_type_of_ship samplesub) );
    ( "get_hits submarine" >:: fun _ ->
      assert_equal ~printer:pretty_int 0 (X.get_hits samplesub) );
    ( "get_sunk submarine" >:: fun _ ->
      assert_equal ~printer:pretty_bool false (X.get_sunk samplesub) );

    ( "get_health patrol boat" >:: fun _ ->
      assert_equal ~printer:pretty_int 2 (X.get_health samplepb) );
    ( "get_length patrol boat" >:: fun _ ->
      assert_equal ~printer:pretty_int 2 (X.get_length samplepb) );
    ( "get_type_of_ship patrol boat" >:: fun _ ->
      assert_equal ~printer:pretty_string "Patrol Boat"
        (X.get_type_of_ship samplepb) );
    ( "get_hits patrol boat" >:: fun _ ->
      assert_equal ~printer:pretty_int 0 (X.get_hits samplepb) );
    ( "get_sunk patrol boat" >:: fun _ ->
      assert_equal ~printer:pretty_bool false (X.get_sunk samplepb) );

    ( "hit_ship patrol boat" >:: fun _ ->
      assert_equal ~printer:pretty_int 1 healthpb );
    ( "hit_ship again patrol boat" >:: fun _ ->
      assert_equal ~printer:pretty_int 0 healthpb2 );
    ( "get_hits on sunk patrol boat" >:: fun _ ->
      assert_equal ~printer:pretty_int 2 (X.get_hits samplepb2) );
    ( "get_sunk patrol boat" >:: fun _ ->
      assert_equal ~printer:pretty_bool true (X.get_sunk samplepb2) );
    ( "get_pos patrol boat" >:: fun _ ->
      assert_equal ~printer:pretty_bool true (X.get_pos samplepb2 0 0) );
  ]

module SB = Zero_Degrees.ShipsBag.PlayerList

let samplebag = SB.build_bag 1
let samplebag2 = SB.build_bag 2

let sample_healthlist =
  "+ Carrier Ship Health 5 of 5\n\
  \  + Battleship Ship Health 4 of 4\n\
  \  + Destroyer Ship Health 3 of 3\n\
  \  + Submarine Ship Health 3 of 3\n\
  \  + Patrol Boat Ship Health 2 of 2"

(* Instructions to sink all ships in samplebag2. Helper for testing all_sunk. *)
let sink_all =
  let c = SB.get_Carrier samplebag2 in
  let b = SB.get_Battleship samplebag2 in
  let d = SB.get_Destroyer samplebag2 in
  let s = SB.get_Submarine samplebag2 in
  let pb = SB.get_patrolBoat samplebag2 in
  let set =
    [
      X.set_position c 0 0 0 4;
      X.set_position b 1 0 1 3;
      X.set_position d 2 0 2 2;
      X.set_position s 3 0 3 2;
      X.set_position pb 4 0 4 1;
    ]
  in
  let sink =
    [
      X.hit_ship c (0, 0);
      X.hit_ship c (0, 1);
      X.hit_ship c (0, 2);
      X.hit_ship c (0, 3);
      X.hit_ship c (0, 4);
      X.hit_ship b (1, 0);
      X.hit_ship b (1, 1);
      X.hit_ship b (1, 2);
      X.hit_ship b (1, 3);
      X.hit_ship d (2, 0);
      X.hit_ship d (2, 1);
      X.hit_ship d (2, 2);
      X.hit_ship s (3, 0);
      X.hit_ship s (3, 1);
      X.hit_ship s (3, 2);
      X.hit_ship pb (4, 0);
      X.hit_ship pb (4, 1);
    ]
  in
  ()

let ships_bag_tests =
  [
    ( "bag get_carrier" >:: fun _ ->
      assert_equal (X.build_ship "Carrier") (SB.get_Carrier samplebag) );
    ( "bag get_battleship" >:: fun _ ->
      assert_equal (X.build_ship "Battleship") (SB.get_Battleship samplebag) );
    ( "bag get_destroyer" >:: fun _ ->
      assert_equal (X.build_ship "Destroyer") (SB.get_Destroyer samplebag) );
    ( "bag get_submarine" >:: fun _ ->
      assert_equal (X.build_ship "Submarine") (SB.get_Submarine samplebag) );
    ( "bag get_patrolboat" >:: fun _ ->
      assert_equal (X.build_ship "Patrol Boat") (SB.get_patrolBoat samplebag) );
    ( "bag list_health" >:: fun _ ->
      assert_equal (print_endline sample_healthlist) (SB.list_health samplebag)
    );
    ( "bag all_sunk" >:: fun _ -> assert_equal false (SB.all_sunk samplebag));
    ( "bag all_sunk" >:: fun _ ->
      assert_equal ~printer:pretty_bool true (SB.all_sunk samplebag2) );
  ]

module B = Zero_Degrees.Board.BattleGround
let sampleboard = B.set_up_board Ocean 
let placepb= B.place_ship sampleboard samplepb 0 0 1 0 
let placec = B.place_ship sampleboard samplecarrier 2 0 2 4 
let samplesub2 = X.build_ship "Submarine"
let places = B.place_ship sampleboard samplesub2 3 0 3 2
let shotsub = B.shoot sampleboard 3 0
let shotsubt = B.shoot sampleboard 3 2
let shotocean = B.shoot sampleboard 9 9
let board_tests = [
  ( "board ocean" >:: fun _ ->
    assert_equal (B.Ocean) (B.get_pos sampleboard 5 5) );
  ( "board placed pb head" >:: fun _ ->
    assert_equal (B.Ship samplepb) (B.get_pos sampleboard 0 0) );
  ( "board placed pb tail" >:: fun _ ->
    assert_equal (B.Ship samplepb) (B.get_pos sampleboard 1 0) );
  ( "board placed carrier head" >:: fun _ ->
    assert_equal (B.Ship samplecarrier) (B.get_pos sampleboard 2 0) );
  ( "board placed carrier tail" >:: fun _ ->
    assert_equal (B.Ship samplecarrier) (B.get_pos sampleboard 2 4) );
  ( "board check_valid existing pb" >:: fun _ ->
    assert_equal ~printer:pretty_bool (false) 
      (B.check_valid sampleboard samplepb 0 0 1 0) );
  ( "board check_valid ocean" >:: fun _ ->
    assert_equal ~printer:pretty_bool (true) 
      (B.check_valid sampleboard samplepb 5 5 5 6) );
  ( "board check_valid existing carrier" >:: fun _ ->
    assert_equal ~printer:pretty_bool (false) 
      (B.check_valid sampleboard samplecarrier 2 0 2 4) );
  ( "board hit head" >:: fun _ -> 
    assert_equal (B.Hit) (B.get_pos sampleboard 3 0) );
  ( "board hit tail" >:: fun _ -> 
      assert_equal (B.Hit) (B.get_pos sampleboard 3 2) );
  ( "board miss" >:: fun _ -> 
    assert_equal (B.Miss) (B.get_pos sampleboard 9 9) );
]

module C = Zero_Degrees.Computer.AIComp
let sampleboardai = C.set_board_ai (C.create_ai)
let samplebg = B.set_up_board Ocean
let samplebag3 = SB.build_bag 3
let computer_tests = [
  ( "computer board setup" >:: fun _ -> 
    assert_equal () sampleboardai );
  (* ( "computer get_bag" >:: fun _ -> 
    assert_equal (samplebag3) (C.get_bag C.create_ai) ); *)
]

let suite =
  "suite" >::: List.flatten [ 
    ship_tests; 
    ships_bag_tests; 
    board_tests; 
    computer_tests; 
  ]

let () = run_test_tt_main suite
