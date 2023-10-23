open Zero_Degrees
open Board
open ShipsBag
open Ship

let () =
  print_endline "Welcome to the Artic Battleship Game!";
  print_endline "Player 1 please input your name: ";
  let player_1_name = read_line () in

  (* print_endline ("Player 2 please input your name: "); let player_2_name =
     read_line () in *)
  (* print_endline "You will place your ships on your battle ground grid."; *)
  (* print_endline
    (player_1_name
   ^ " how long/wide of a square battle ground would you like? (Minimum size = \
      10)");
  let p1_size = int_of_string (read_line ()) in *)

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

   print_endline("Captain " ^ player_1_name ^ " you will place 5 ships: 1 Carrier ship 1 BattleShip 1 Destoryer 1 
     Submarine 1 PatrolBoat");

   
   let p1ShipBag = Player1List.build_bag in
   let p1BattleGrid = BattleGround.set_up_board in


   print_endline("First Provide a head and tail positon for your "^ 
   (p1ShipBag |> Player1List.get_Carrier |> AShip.get_type_of_Ship));

   print_endline("Head position in the fromat x y");
   let head_Pos_List = String.split_on_char ' ' (read_line()) in
   let x1 = int_of_string(List.nth head_Pos_List 0 )in 
   let y1 = int_of_string(List.nth head_Pos_List 1 )in 

   print_endline("Tail position in the format x y");
   let tail_Pos_List = String.split_on_char ' ' (read_line()) in
   let x2 = int_of_string(List.nth tail_Pos_List 0 )in 
   let y2 = int_of_string(List.nth tail_Pos_List 1) in 

   let ship_to_place = (p1ShipBag |> Player1List.get_Carrier) in 

   let p1BattleGrid = BattleGround.place_ship (p1BattleGrid) (ship_to_place) x1 y1 x2 y2 in

   print_endline("reached");

   let rec printOutR (battleGround_Input:BattleGround.t) (row: int) =
      let () = printOutC(battleGround_Input)(row)(0) in 
      printOutR (battleGround_Input)(row+1);

   let rec printOutC (battleGround_Input:BattleGround.t) (fixed_row: int) (col: int) = 
      if (col > 10) then print_endline("") else
      match (BattleGround.get_pos battleGround_Input) with
      | BattleGround.occupy -> print_string (".");
      | Ship s -> print_string("x");

      printOutC (print_Grid)(fixed_row)(col+1) 

   
    print_endline("reached");
   

(* Player1List.t = *)

(* print_endline ("Captain " ^ player_1_name ^ "enter the coordiante of where
   you would like to the head of your carrier ship to be:"); let carrier_head =
   read_line() in let corr_list = String.split_on_char ' ' carrier_head in let
   x1 = int_of_string(List.nth corr_list 0 )in let y1 = int_of_string (List.nth
   corr_list 1) in

   let p1Carrier = Carrier.build_ship 5 in

   let tail_pos = BattleGround.ship_positons (Carrier p1Carrier) x1 y1 in let
   tail_pos_strings= List.fold_left (fun add p -> add ^ (string_of_int p)) ""
   tail_pos

   print_endline (player_1_name ^" enter the one of the following allowed tail
   coordiantes of your carrier ship:" ^ (String.concat ", " tail_pos)); let
   carrier_tail = read_line() in let corr_list= String.split_on_char ' '
   carrier_head in let x2= List.nth corr_list 0 in let y2 = List.nth corr_list 1
   in print_endline (player_1_name ^" you succesful placed your Carrier ship
   at"); *)
