open Zero_Degrees
open Board
open ShipsBag
open Ship
open Computer

(* let rec printOutC (battleGround_Input : BattleGround.t) (fixed_row : int)
   (col : int) : unit = if col > 9 then print_endline "" else match
   BattleGround.get_pos battleGround_Input fixed_row col with | Ocean ->
   print_string "." | Ship s -> print_string "x"; printOutC battleGround_Input
   fixed_row (col + 1)

   let rec printOutR (battleGround_Input : BattleGround.t) (row : int) : unit =
   printOutC battleGround_Input row 0; print_endline ""; printOutR
   battleGround_Input (row + 1) *)

let rec horizontal_Lines (size : int) : string =
  if size > 0 then "----" ^ horizontal_Lines (size - 1) else ""

let print_Grid (grid : BattleGround.occupy array array) =
  for y = 0 to 9 do
    (* if y = 0 then print_string(horizontal_Lines (Array.length(grid))); *)
    for x = 0 to 9 do
      if x = 0 then print_string "|" else print_string "";
      match Array.get (Array.get grid x) y with
      | BattleGround.Ocean ->
          let () = print_string " o |" in
          if x = 9 then
            let () = print_newline () in
            let () = print_string (horizontal_Lines (Array.length grid)) in
            print_endline ""
      | BattleGround.Ship s ->
          let () = print_string " x |" in
          if x = 9 then
            let () = print_newline () in
            let () = print_string (horizontal_Lines (Array.length grid)) in
            print_endline ""
    done
    (* print_newline() *)
    (* print_endline(horizontal_Lines (Array.length(grid))) *)
  done

let helper_To_Print2 (row : BattleGround.occupy array) =
  Array.iter
    (fun elem ->
      match elem with
      | BattleGround.Ocean -> print_string " o |"
      | BattleGround.Ship s -> print_string " x |")
    row

let helper_To_Print1 (grid : BattleGround.occupy array array) =
  Array.iter
    (fun row ->
      let () = print_string "|" in
      let () = helper_To_Print2 row in
      let () = print_endline "" in
      print_endline (horizontal_Lines (Array.length grid)))
    grid

let () =
  print_endline "Welcome to the Artic Battleship Game!";
  print_endline "Player 1 please input your name: ";
  let player_1_name = read_line () in

  (* print_endline ("Player 2 please input your name: "); let player_2_name =
     read_line () in *)
  (* print_endline "You will place your ships on your battle ground grid."; *)
  (* print_endline (player_1_name ^ " how long/wide of a square battle ground
     would you like? (Minimum size = \ 10)"); let p1_size = int_of_string
     (read_line ()) in *)

  (* print_endline (player_2_name ^" how long/wide of a square battle ground
     would you like? (Minimum size = 10)"); let p2_size =
     int_of_string(read_line ()) in

     let avg_size = int_of_float(Float.round(((float_of_int(p1_size)) +.
     (float_of_int(p2_size))) /. 2.0 )) in

     if (p1_size = p2_size) then print_endline ("Both player agrees!! We will
     play on a " ^ string_of_int(p1_size)^" x " ^ string_of_int(p1_size)^" size
     grid!") else print_endline ("We will meet at the middle and we will play on
     a " ^ string_of_int(avg_size)^" x " ^ string_of_int(avg_size)^" size
     grid!"); let p1_Board = BattleGround.set_up_board (avg_size) ; let p2_Board
     = BattleGround.set_up_board (avg_size) ; *)
  print_endline
    ("Okay great Captain " ^ player_1_name
   ^ " we will play on a battle grid of size of 10 x 10");

  print_newline ();
  print_endline
    ("Captain " ^ player_1_name
   ^ " you will place 5 ships: 1 Carrier ship 1 BattleShip 1 Destoryer 1 "
   ^ "Submarine 1 PatrolBoat");
  print_newline ();
  let p1ShipBag = Player1List.build_bag in
  let p1BattleGrid = BattleGround.set_up_board in

  (* Carrier placement *)
  print_endline
    ("First Provide a head and tail positon for your "
    ^ (p1ShipBag |> Player1List.get_Carrier |> AShip.get_type_of_ship)
    ^ " (Which has a length of 5)");
  print_newline ();
  print_endline "Head position in the fromat x y";
  let head_Pos_List = String.split_on_char ' ' (read_line ()) in
  let x1 = int_of_string (List.nth head_Pos_List 0) in
  let y1 = int_of_string (List.nth head_Pos_List 1) in
  print_newline ();
  print_endline "Tail position in the format x y";
  let tail_Pos_List = String.split_on_char ' ' (read_line ()) in
  let x2 = int_of_string (List.nth tail_Pos_List 0) in
  let y2 = int_of_string (List.nth tail_Pos_List 1) in
  print_newline ();
  let ship_to_place = p1ShipBag |> Player1List.get_Carrier in

  let p1BattleGrid =
    BattleGround.place_ship p1BattleGrid ship_to_place x1 y1 x2 y2
  in

  (* Battlehsip placement *)
  print_endline
    ("Now Provide a head and tail positon for your "
    ^ (p1ShipBag |> Player1List.get_Battleship |> AShip.get_type_of_ship)
    ^ " (Which has a length of 4)");
  print_newline ();
  print_endline "Head position in the fromat x y";
  let head_Pos_List = String.split_on_char ' ' (read_line ()) in
  let x1 = int_of_string (List.nth head_Pos_List 0) in
  let y1 = int_of_string (List.nth head_Pos_List 1) in
  print_newline ();
  print_endline "Tail position in the format x y";
  let tail_Pos_List = String.split_on_char ' ' (read_line ()) in
  let x2 = int_of_string (List.nth tail_Pos_List 0) in
  let y2 = int_of_string (List.nth tail_Pos_List 1) in
  print_newline ();
  let ship_to_place = p1ShipBag |> Player1List.get_Battleship in

  let p1BattleGrid =
    BattleGround.place_ship p1BattleGrid ship_to_place x1 y1 x2 y2
  in

  (* Destroyer placement *)
  print_endline
    ("Now Provide a head and tail positon for your "
    ^ (p1ShipBag |> Player1List.get_Destroyer |> AShip.get_type_of_ship)
    ^ " (Which has a length of 3)");
  print_newline ();
  print_endline "Head position in the fromat x y";
  let head_Pos_List = String.split_on_char ' ' (read_line ()) in
  let x1 = int_of_string (List.nth head_Pos_List 0) in
  let y1 = int_of_string (List.nth head_Pos_List 1) in
  print_newline ();
  print_endline "Tail position in the format x y";
  let tail_Pos_List = String.split_on_char ' ' (read_line ()) in
  let x2 = int_of_string (List.nth tail_Pos_List 0) in
  let y2 = int_of_string (List.nth tail_Pos_List 1) in
  print_newline ();
  let ship_to_place = p1ShipBag |> Player1List.get_Destroyer in

  let p1BattleGrid =
    BattleGround.place_ship p1BattleGrid ship_to_place x1 y1 x2 y2
  in

  (* Submarine placement *)
  print_endline
    ("Now Provide a head and tail positon for your "
    ^ (p1ShipBag |> Player1List.get_Submarine |> AShip.get_type_of_ship)
    ^ " (Which has a length of 3)");
  print_newline ();
  print_endline "Head position in the fromat x y";
  let head_Pos_List = String.split_on_char ' ' (read_line ()) in
  let x1 = int_of_string (List.nth head_Pos_List 0) in
  let y1 = int_of_string (List.nth head_Pos_List 1) in
  print_newline ();
  print_endline "Tail position in the format x y";
  let tail_Pos_List = String.split_on_char ' ' (read_line ()) in
  let x2 = int_of_string (List.nth tail_Pos_List 0) in
  let y2 = int_of_string (List.nth tail_Pos_List 1) in
  print_newline ();
  let ship_to_place = p1ShipBag |> Player1List.get_Submarine in

  let p1BattleGrid =
    BattleGround.place_ship p1BattleGrid ship_to_place x1 y1 x2 y2
  in

  (* Patrol Boat placement *)
  print_endline
    ("Now Provide a head and tail positon for your "
    ^ (p1ShipBag |> Player1List.get_patrolBoat |> AShip.get_type_of_ship)
    ^ " (Which has a length of 2)");
  print_newline ();
  print_endline "Head position in the fromat x y";
  let head_Pos_List = String.split_on_char ' ' (read_line ()) in
  let x1 = int_of_string (List.nth head_Pos_List 0) in
  let y1 = int_of_string (List.nth head_Pos_List 1) in
  print_newline ();
  print_endline "Tail position in the format x y";
  let tail_Pos_List = String.split_on_char ' ' (read_line ()) in
  let x2 = int_of_string (List.nth tail_Pos_List 0) in
  let y2 = int_of_string (List.nth tail_Pos_List 1) in
  print_newline ();
  let ship_to_place = p1ShipBag |> Player1List.get_patrolBoat in

  let p1BattleGrid =
    BattleGround.place_ship p1BattleGrid ship_to_place x1 y1 x2 y2
  in
  print_Grid (BattleGround.get_board p1BattleGrid);

  (* print_endline(" "^ horizontal_Lines(Array.length (BattleGround.get_board
     p1BattleGrid ))); helper_To_Print1 (BattleGround.get_board
     p1BattleGrid); *)
  print_endline "Your Battle Grid is set!!";

  print_endline "The health of your ships: ";
  Player1List.list_health p1ShipBag
