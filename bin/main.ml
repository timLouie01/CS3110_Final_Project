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
    for x = 0 to 9 do
      if x = 0 then print_string (string_of_int y ^ " |") else print_string "";
      match Array.get (Array.get grid x) y with
      | BattleGround.Ocean ->
          let () = print_string "   |" in
          if x = 9 then (
            let () = print_newline () in
            print_string "- -----------------------------------------";
            print_endline "")
      | BattleGround.Ship s ->
          let () = print_string " x |" in
          if x = 9 then (
            let () = print_newline () in
            print_string "- -----------------------------------------";
            print_endline "")
      | BattleGround.Hit ->
          let () = print_string " H |" in
          if x = 9 then (
            let () = print_newline () in
            print_string "- -----------------------------------------";
            print_endline "")
      | BattleGround.Miss ->
          let () = print_string " M |" in
          if x = 9 then (
            let () = print_newline () in
            print_string "- -----------------------------------------";
            print_endline "")
    done
  done

let print_oneline_grid (grid : BattleGround.occupy array array) (y : int) =
  for x = 0 to 9 do
    if x = 0 then print_string (string_of_int y ^ " |") else print_string "";
    match Array.get (Array.get grid x) y with
    | BattleGround.Ocean ->
        let () = print_string "   |" in
        if x = 9 then print_string ""
    | BattleGround.Ship s ->
        let () = print_string " x |" in
        if x = 9 then print_string ""
    | BattleGround.Hit ->
        let () = print_string " H |" in
        if x = 9 then print_string ""
    | BattleGround.Miss ->
        let () = print_string " M |" in
        if x = 9 then print_string ""
  done

let print_two_Grid (grid1 : BattleGround.occupy array array)
    (grid2 : BattleGround.occupy array array) =
  print_endline
    "  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |       | 0 | 1 | 2 | 3 | 4 | 5 \
     | 6 | 7 | 8 | 9 |";
  print_endline
    "- -----------------------------------------     - \
     -----------------------------------------";
  for y = 0 to 9 do
    print_oneline_grid grid1 y;
    print_string "     ";
    print_oneline_grid grid2 y;
    print_newline ();
    print_endline
      "- -----------------------------------------     - \
       -----------------------------------------"
  done

let () =
  Sys.command "clear";
  print_endline "-------------------------------------------";
  print_endline "==> Welcome to the Artic Battleship Game!";
  print_string "==> Player 1 please input your name: ";
  let player_1_name = String.trim (read_line ()) in

  Sys.command "clear";
  print_endline
    ("==> Hi Captain " ^ player_1_name
   ^ "! We will play on a battle grid of size of 10 x 10.");

  print_newline ();
  print_endline
    ("==> Captain " ^ player_1_name
   ^ ", you will place 5 ships: 1 Carrier ship, 1 BattleShip, 1 Destroyer, 1 "
   ^ "Submarine, 1 Patrol Boat");
  print_newline ();

  let p1_ship_bag = PlayerList.build_bag 5 in
  let p1_battle_grid = BattleGround.set_up_board BattleGround.Ocean in
  let p1_tracking_grid = BattleGround.set_up_board BattleGround.Ocean in
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

  let check_int (s : string) : int = try int_of_string s with _ -> 11 in
  let check_input () : string = try read_line () with _ -> "11 11 11" in

  let rec place_all_ships
      (ships_list : (string * int * (PlayerList.t -> AShip.t)) list)
      (p1_grid : BattleGround.t) : BattleGround.t =
    match ships_list with
    | (ship_name, length, get_function) :: t -> (
        print_newline ();
        print_endline
          ("--- Placing your " ^ ship_name ^ " of length "
         ^ string_of_int length ^ " ---");
        print_newline ();
        print_endline
          ("==> Captain " ^ player_1_name
         ^ ", Please provide the head position in the (format: x y <N/S/E/W>)");
        let head_Pos_List =
          String.split_on_char ' ' (check_input ()) @ [ "11"; "11"; "11" ]
        in
        let x1 = check_int (List.nth head_Pos_List 0) in
        let y1 = check_int (List.nth head_Pos_List 1) in
        let position =
          String.uppercase_ascii (String.trim (List.nth head_Pos_List 2))
        in
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
            Sys.command "clear";
            print_Grid (BattleGround.get_board p1_grid);

            place_all_ships t p1_grid
        | false ->
            print_endline "<<!INVALID PLACEMENT! Please try again.>>";
            print_newline ();
            place_all_ships ((ship_name, length, get_function) :: t) p1_grid)
    | [] -> p1_grid
  in

  print_Grid (BattleGround.get_board p1_battle_grid);
  let p1_battle_grid = place_all_ships ships_to_place p1_battle_grid in
  print_endline "==> Your Battle Grid is set!!";
  print_endline "Press enter to begin the game...";
  let _ = String.trim (read_line ()) in

  Sys.command "clear";

  let print_view () =
    print_endline "==> Your ship healths: ";
    PlayerList.list_health p1_ship_bag;
    print_newline ();
    print_endline
      "          <<< Your Board >>>                                <<< Enemy's \
       Board >>>";
    print_two_Grid
      (BattleGround.get_board p1_battle_grid)
      (BattleGround.get_board p1_tracking_grid);
    print_newline ()
  in

  let _ = Sys.command "clear" in

  print_endline "------------- Let the game begin! -------------";
  print_view ();

  (* Creating the AI Computer board*)
  let computer_P2 = AIComp.create_ai in
  let () = AIComp.set_board_ai computer_P2 in

  let continue_game = ref true in

  (* While loop to keep playing the game *)
  while continue_game = ref true do
    (*Player 1 is shooting*)
    let next = ref 0 in
    let x1 = ref 0 in
    let y1 = ref 0 in
    while !next = 0 do
      print_endline
        "==> Enter the coordinates you would like to shoot at (format x y): ";
      let shoot_pos_list =
        String.split_on_char ' ' (check_input ()) @ [ "11"; "11"; "11" ]
      in
      x1 := check_int (List.nth shoot_pos_list 0);
      y1 := check_int (List.nth shoot_pos_list 1);

      if !x1 > 10 || !y1 > 10 then
        print_endline "==> INVALID COORDINATES, try again"
      else next := 1
    done;

    Sys.command "clear";
    let shoot_result =
      BattleGround.shoot (AIComp.get_board computer_P2) !x1 !y1
    in

    (*Results of Player 1 shots*)
    let () =
      match shoot_result.shot with
      | true ->
          let () = print_endline "[ You HIT something! ]" in
          (BattleGround.get_board p1_tracking_grid).(!x1).(!y1) <-
            BattleGround.Hit;
          print_view ()
      | false ->
          let () = print_endline "[ You MISSED! :( ]" in
          (BattleGround.get_board p1_tracking_grid).(!x1).(!y1) <-
            BattleGround.Miss;
          print_view ()
    in

    print_endline "Computer is shooting... Press enter to continue...";
    String.trim (read_line ());
    Sys.command "clear";

    (*AI Computer is shooting*)
    AIComp.set_board computer_P2 shoot_result.board_type;

    if PlayerList.all_sunk (AIComp.get_bag computer_P2) = true then
      let _ = Sys.command "clear" in

      let _ =
        print_Grid (BattleGround.get_board (AIComp.get_board computer_P2))
      in
      let _ = print_newline () in
      let () = print_endline "==> YOU WON!" in
      continue_game := false
    else continue_game := true;

    if continue_game = ref true then
      let ai_shot = AIComp.rand_Move computer_P2 p1_battle_grid in
      if ai_shot.shot then
        match ai_shot.ship_shot with
        | Some a ->
            print_endline ("and HIT your " ^ AShip.get_type_of_ship a ^ "! ]");
            print_view ();
            if PlayerList.all_sunk p1_ship_bag = true then
              let () = print_endline "==> YOU LOST!" in
              continue_game := false
            else continue_game := true
        | None -> print_endline "==> Unreachable Code"
      else (
        print_endline "and MISSED! ]";
        print_view ())
    else print_endline "==> YOU WON!!"
  done
