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
  if size > 0 then "-----" ^ horizontal_Lines (size - 1) else ""

let print_Grid (grid : BattleGround.occupy array array) =
  print_endline "  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |";
  print_endline "- -----------------------------------------";
  for y = 0 to 9 do
    (* if y = 0 then print_string(horizontal_Lines (Array.length(grid))); *)
    for x = 0 to 9 do
      if x = 0 then print_string (string_of_int y ^ " |") else print_string "";
      match Array.get (Array.get grid x) y with
      | BattleGround.Ocean ->
          let () = print_string " o |" in
          if x = 9 then (
            let () = print_newline () in
            (* let () = print_string (horizontal_Lines (Array.length grid))
               in *)
            print_string "- -----------------------------------------";
            print_endline "")
      | BattleGround.Ship s ->
          let () = print_string " x |" in
          if x = 9 then (
            let () = print_newline () in
            (* let () = print_string (horizontal_Lines (Array.length grid))
               in *)
            print_string "- -----------------------------------------";
            print_endline "")
      | BattleGround.Hit ->
          let () = print_string " H |" in
          if x = 9 then (
            let () = print_newline () in
            (* let () = print_string (horizontal_Lines (Array.length grid))
               in *)
            print_string "- -----------------------------------------";
            print_endline "")
      | BattleGround.Miss ->
          let () = print_string " M |" in
          if x = 9 then (
            let () = print_newline () in
            (* let () = print_string (horizontal_Lines (Array.length grid))
               in *)
            print_string "- -----------------------------------------";
            print_endline "")
    done
    (* print_newline() *)
    (* print_endline(horizontal_Lines (Array.length(grid))) *)
  done

let () =
  print_endline "Welcome to the Artic Battleship Game!";
  print_endline "Player 1 please input your name: ";
  let player_1_name = String.trim (read_line ()) in

  print_endline
    ("Hi Captain " ^ player_1_name
   ^ "! We will play on a battle grid of size of 10 x 10.");

  print_newline ();
  print_endline
    ("Captain " ^ player_1_name
   ^ ", you will place 5 ships: 1 Carrier ship 1 BattleShip 1 Destoryer 1 "
   ^ "Submarine 1 Patrol Boat");
  print_newline ();

  let p1_ship_bag = PlayerList.build_bag 5 in
  let p1_battle_grid = BattleGround.set_up_board BattleGround.Ocean in
  let p1_tracking_grid = BattleGround.set_up_board BattleGround.Ocean in
  (* let p2_ship_bag = PlayerList.build_bag in let p2_battle_grid =
     BattleGround.set_up_board in *)
  let ships_to_place =
    [
      ("Carrier", 5, PlayerList.get_Carrier);
      ("Battleship", 4, PlayerList.get_Battleship);
      ("Destroyer", 3, PlayerList.get_Destroyer);
      ("Submarine", 3, PlayerList.get_Submarine);
      ("Patrol Boat", 2, PlayerList.get_patrolBoat);
    ]
  in

  let calculate_tail (x1 : int) (y1 : int) (size : int) (position : string) :
      int list =
    match position with
    | "N" -> [ x1; y1 - (size - 1) ]
    | "E" -> [ x1 + (size - 1); y1 ]
    | "W" -> [ x1 - (size - 1); y1 ]
    | "S" -> [ x1; y1 + (size - 1) ]
    | _ -> [ 0; 0 ]
  in

  let rec place_all_ships
      (ships_list : (string * int * (PlayerList.t -> AShip.t)) list)
      (p1_grid : BattleGround.t) : BattleGround.t =
    match ships_list with
    | (ship_name, length, get_function) :: t -> (
        print_endline
          ("Captain " ^ player_1_name
         ^ " please provide the head positon for your " ^ ship_name
         ^ " (Which has a length of " ^ string_of_int length ^ ")");
        print_newline ();
        print_endline "Please provide the head position in the format x y";
        let head_Pos_List = String.split_on_char ' ' (read_line ()) in
        let x1 = int_of_string (List.nth head_Pos_List 0) in
        let y1 = int_of_string (List.nth head_Pos_List 1) in
        print_newline ();
        print_endline
          ("Captain, " ^ player_1_name ^ " how should we position the "
         ^ ship_name);
        print_endline
          "Enter N to point the tail north, S for south, E for east, and W for \
           west.";
        let position = String.uppercase_ascii (String.trim (read_line ())) in
        print_newline ();
        let tail_pos = calculate_tail x1 y1 length position in
        let ship_to_place = p1_ship_bag |> get_function in
        let output_record =
          BattleGround.place_ship p1_grid ship_to_place x1 y1
            (List.nth tail_pos 0) (List.nth tail_pos 1)
        in
        let p1_grid = output_record.board_type in
        let added_check = output_record.added in
        match added_check with
        | true ->
            print_Grid (BattleGround.get_board p1_grid);
            place_all_ships t p1_grid
        | false ->
            print_endline
              "That was an invalid head position and tail 
\n\n\
              \              direciton combination!";
            print_endline ("Please enter new coordiantes for your" ^ ship_name);
            place_all_ships ((ship_name, length, get_function) :: t) p1_grid)
    | [] -> p1_grid
  in

  print_Grid (BattleGround.get_board p1_battle_grid);
  let p1_battle_grid = place_all_ships ships_to_place p1_battle_grid in
  print_endline "Your Battle Grid is set!!";

  print_endline "The health of your ships: ";
  PlayerList.list_health p1_ship_bag;
  print_endline "Tracking Grid:";
  print_Grid (BattleGround.get_board p1_tracking_grid);

  (* Comment this out later (for now use to see if you are supposed to hit
     ship) *)
  print_endline "Enemy Lines";
  let computer_P2 = AIComp.create_ai in
  let () = AIComp.set_board_ai computer_P2 in
  print_Grid (BattleGround.get_board (AIComp.get_board computer_P2));
  PlayerList.list_health (AIComp.get_bag computer_P2);

  print_endline "We will begin the Game Now!";
  let continue_game = ref true in
  (* While loop to keep playing the game *)
  while continue_game = ref true do
(* Get rid of this for produciton code leaving for testing *)
    print_endline "Opponent's grid";
    print_Grid (BattleGround.get_board (AIComp.get_board computer_P2));

    print_endline "Enter coordinates you would like to shoot at: ";
    print_endline "Please provide the position in the format x y";
    let shoot_pos_list = String.split_on_char ' ' (read_line ()) in
    let x1 = int_of_string (List.nth shoot_pos_list 0) in
    let y1 = int_of_string (List.nth shoot_pos_list 1) in

    let shoot_result =
      BattleGround.shoot (AIComp.get_board computer_P2) x1 y1
    in

    (* if shoot_result.shot then
      let () = print_endline "There is hit!" in
      (BattleGround.get_board p1_tracking_grid).(x1).(y1) <- BattleGround.Hit
    else let () = print_endline "You missed" in (
      BattleGround.get_board p1_tracking_grid).(x1).(y1) <- BattleGround.Miss; *)
    let () = match shoot_result.shot with
    | true ->  let () = print_endline "There is hit!" in
    (BattleGround.get_board p1_tracking_grid).(x1).(y1) <- BattleGround.Hit
    | false -> let () = print_endline "You missed" in (
      BattleGround.get_board p1_tracking_grid).(x1).(y1) <- BattleGround.Miss; in

    print_endline "Tracking Grid:";
    print_Grid (BattleGround.get_board p1_tracking_grid);

    AIComp.set_board computer_P2 shoot_result.board_type;

    print_endline "Opponent's grid";
    print_Grid (BattleGround.get_board (AIComp.get_board computer_P2));

    print_endline "Health of opponent Ships: ";
    PlayerList.list_health (AIComp.get_bag computer_P2);

    if PlayerList.all_sunk (AIComp.get_bag computer_P2) = true then
      let () = print_endline "You won!" in
      continue_game := false
    else continue_game := true;

    if continue_game = ref true then
      let ai_shot = AIComp.rand_Move computer_P2 p1_battle_grid in
      if ai_shot.shot then
        match ai_shot.ship_shot with
        | Some a ->
            print_endline ("The Computer hit your " ^ AShip.get_type_of_ship a);
            print_endline ("Your Gird: ");
            print_Grid (BattleGround.get_board p1_battle_grid);
            print_endline "The health of your xships: ";
            PlayerList.list_health p1_ship_bag;
            if PlayerList.all_sunk (p1_ship_bag) = true then 
              let () = print_endline "You Lost!" in continue_game := false
          else continue_game := true;
        | None ->
            print_endline
              "This won't happend since
              this code is only reached when ai_shot.shot true"
      else print_endline "The Computer missed you!"
    else print_endline "You won!!"
  done
