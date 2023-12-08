open Zero_Degrees
open Board
open ShipsBag
open Ship
open Computer
module T = ANSITerminal
open Printf
(* open Ocolor_format *)

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
  (* T.prerr_string [ T.Foreground T.Blue ] "test"; *)
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
          let () =
            match Ship.AShip.get_type_of_ship s with
            | "Carrier" -> print_string " C |"
            | "Battleship" -> print_string " B |"
            | "Destroyer" -> print_string " D |"
            | "Submarine" -> print_string " S |"
            | "Patrol Boat" -> print_string " P |"
            | _ -> print_string "error"
          in
          if x = 9 then (
            let () = print_newline () in
            print_string "- -----------------------------------------";
            print_endline "")
      | BattleGround.Hit ->
          let () = T.print_string [ T.Bold; Foreground Red ; Background White ] " H " in
          let () = T.print_string [ T.Bold; Foreground White ; Background Black ] "|" in
          if x = 9 then (
            let () = print_newline () in
            print_string "- -----------------------------------------";
            print_endline "")
      | BattleGround.Miss ->
        let () = T.print_string [ T.Bold; Foreground White ; Background Blue ] " M " in
        let () = T.print_string [ T.Bold; Foreground White ; Background Black ] "|" in
          if x = 9 then (
            let () = print_newline () in
            print_string "- -----------------------------------------";
            print_endline "")
    done
  done

let print_oneline_grid (grid : BattleGround.occupy array array) (y : int)
    ?(shield_spot = (-1, -1)) =
  match shield_spot with
  | xs, ys ->
      for x = 0 to 9 do
        if x = 0 then print_string (string_of_int y ^ " |") else print_string "";
        if xs = x && ys = y then
          let () = T.print_string [ T.Bold; Foreground Magenta ; Background Cyan] " ^ " in
           T.print_string [ T.Bold; Foreground White ; Background Black ] "|"
        else
          match Array.get (Array.get grid x) y with
          | BattleGround.Ocean ->
              let () = print_string "   |" in
              if x = 9 then print_string ""
          | BattleGround.Ship s -> (
              match Ship.AShip.get_type_of_ship s with
              | "Carrier" -> print_string " C |"
              | "Battleship" -> print_string " B |"
              | "Destroyer" -> print_string " D |"
              | "Submarine" -> print_string " S |"
              | "Patrol Boat" -> print_string " P |"
              | _ -> print_string "error")
          | BattleGround.Hit ->
            let () = T.print_string [ T.Bold; Foreground Red ; Background White ] " H " in
            let () = T.print_string [ T.Bold; Foreground White ; Background Black ] "|" in
              (* let () = print_string " H |" in *)
              if x = 9 then print_string ""
          | BattleGround.Miss ->
            let () = T.print_string [ T.Bold; Foreground White ; Background Blue ] " M " in
            let () = T.print_string [ T.Bold; Foreground White ; Background Black ] "|" in
              if x = 9 then print_string ""
      done

let print_two_Grid (grid1 : BattleGround.occupy array array)
    (grid2 : BattleGround.occupy array array) ?(shield_spot = (-1, -1)) =
  match shield_spot with
  | xs, ys ->
      print_endline
        "  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |       | 0 | 1 | 2 | 3 | 4 \
         | 5 | 6 | 7 | 8 | 9 |";
      print_endline
        "- -----------------------------------------     - \
         -----------------------------------------";
      for y = 0 to 9 do
        print_oneline_grid grid1 y ~shield_spot:(xs, ys);
        print_string "     ";
        print_oneline_grid grid2 y ~shield_spot:(-1, -1);
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
  let p1_peeks = ref 2 in
  let p1_shields = ref 4 in
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
  Sys.command "clear";
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

  let print_view ?(shield_spotIN = (-1, -1)) () =
    match shield_spotIN with
    | x, y ->
        print_endline "==> Your ship healths: ";
        PlayerList.list_health p1_ship_bag;
        print_newline ();
        print_endline "==> Your number of peeks left:  ";
        T.print_string [ T.Bold; Foreground Cyan ] (string_of_int !p1_peeks);
        print_endline "";
        print_endline "==> Your number of shields left:  ";
        T.print_string
          [ T.Bold; Foreground Magenta ]
          (string_of_int !p1_shields);
        print_endline "";
        print_endline "";
        print_endline
          "          <<< Your Board >>>                                <<< \
           Enemy's Board >>>";
        print_two_Grid
          (BattleGround.get_board p1_battle_grid)
          (BattleGround.get_board p1_tracking_grid)
          ~shield_spot:(x, y);
        print_newline ()
  in

  let continue = ref true in
  let difficulty = ref AIComp.rand_Move in
  (* Sys.command "clear"; *)
  while continue = ref true do
    print_endline
      "==> What level of difficulty would you like to play? (Enter a 1 or 2 \
       indicating you would like to play against a level1 or level2 computer \
       opponent)";
    let input_level = String.trim (read_line ()) in
    match input_level with
    | "1" ->
        difficulty := AIComp.rand_Move;
        continue := false
    | "2" ->
        difficulty := AIComp.rand1_Move;
        continue := false
    | _ ->
        print_endline "==> INVALID LEVEL, try again";
        continue := true
  done;
  Sys.command "clear";

  print_endline "------------- Let the game begin! -------------";
  print_view ();

  (* Creating the AI Computer board*)
  let computer_P2 = AIComp.create_ai in
  let () = AIComp.set_board_ai computer_P2 in

  let continue_game = ref true in

  (* While loop to keep playing the game *)
  while continue_game = ref true do
    (*Player 1 is shooting*)

    (* Set false each turn *)
    let continue = ref true in
    let peek = ref false in
    while continue = ref true && !p1_peeks > 0 do
      print_endline
        "==> Would you like to use one of your two peeks to see where an \
         oppoent's ship might be? Y/N";
      let input_level = String.trim (read_line ()) in
      match String.uppercase_ascii(input_level) with
      | "Y" ->
          peek := true;
          continue := false
      | "N" ->
          peek := false;
          continue := false
      | _ ->
          print_endline "==> INVALID ANSWER, ANSWER again";
          continue := true
    done;

    (* Sys.command "clear"; *)
    let continue = ref true in
    let shield = ref false in
    while continue = ref true && !p1_shields > 0 do
      print_endline
        "==> Would you like to use one of your 4 shields on a ship? Y/N";
      let input_level = String.trim (read_line ()) in
      match String.uppercase_ascii(input_level) with
      | "Y" ->
          shield := true;
          continue := false
      | "N" ->
          shield := false;
          continue := false
      | _ ->
          print_endline "==> INVALID ANSWER, ANSWER again";
          continue := true
    done;

    (* Sys.command "clear"; *)
    let rec find_hint (list_pos : ((int * int) * bool) list) : int * int =
      match list_pos with
      | ((x, y), b') :: b ->
          if
            (BattleGround.get_board p1_tracking_grid).(x).(y) = BattleGround.Hit
          then find_hint b
          else (x, y)
      | [] -> (-1, -1)
    in

    if !peek then (
      let continue = ref true in
      (* Sys.command "clear"; *)
      while continue = ref true do
        print_endline
          "==> Which ship would you like to spy on? Enter C for Carrier, B for \
           Battleship, D for Destroyer, S for Submarine, P for Patrol boat";
        let input_level = String.uppercase_ascii(String.trim (read_line ())) in
        match input_level with
        | "C" ->
            let list_of_pos =
              AShip.get_pos_list
                (PlayerList.get_Carrier (AIComp.get_bag computer_P2))
            in
            let point = find_hint list_of_pos in
            (match point with
            | x1, y1 ->
                if x1 = -1 then
                  print_endline "==> Unfortunatley their Carrier sunk already"
                else
                  print_endline
                    ("==> The opponent has part of their Carrier located at \
                      pos: " ^ string_of_int x1 ^ ", " ^ string_of_int y1));
            continue := false
        | "B" ->
            let list_of_pos =
              AShip.get_pos_list
                (PlayerList.get_Battleship (AIComp.get_bag computer_P2))
            in
            let point = find_hint list_of_pos in
            (match point with
            | x1, y1 ->
                if x1 = -1 then
                  print_endline
                    "==> Unfortunatley their Battleship sunk already"
                else
                  print_endline
                    ("==> The opponent has part of their Battleship located at \
                      pos: " ^ string_of_int x1 ^ ", " ^ string_of_int y1));
            continue := false
        | "D" ->
            let list_of_pos =
              AShip.get_pos_list
                (PlayerList.get_Destroyer (AIComp.get_bag computer_P2))
            in
            let point = find_hint list_of_pos in
            (match point with
            | x1, y1 ->
                if x1 = -1 then
                  print_endline "==> Unfortunatley their Destroyer sunk already"
                else
                  print_endline
                    ("==> The opponent has part of their Destroyer located at \
                      pos: " ^ string_of_int x1 ^ ", " ^ string_of_int y1));
            continue := false
        | "S" ->
            let list_of_pos =
              AShip.get_pos_list
                (PlayerList.get_Submarine (AIComp.get_bag computer_P2))
            in
            let point = find_hint list_of_pos in
            (match point with
            | x1, y1 ->
                if x1 = -1 then
                  print_endline "==> Unfortunatley their Submarine sunk already"
                else
                  print_endline
                    ("==> The opponent has part of their Submarine located at \
                      pos: " ^ string_of_int x1 ^ ", " ^ string_of_int y1));
            continue := false
        | "P" ->
            let list_of_pos =
              AShip.get_pos_list
                (PlayerList.get_patrolBoat (AIComp.get_bag computer_P2))
            in
            let point = find_hint list_of_pos in
            (match point with
            | x1, y1 ->
                if x1 = -1 then
                  print_endline
                    "==> Unfortunatley their Patrol boat sunk already"
                else
                  print_endline
                    ("==> The opponent has part of their Patrol boat located \
                      at pos: " ^ string_of_int x1 ^ ", " ^ string_of_int y1));
            continue := false
        | _ ->
            print_endline "==> INVALID COORDINATES, try again";
            continue := true
      done;
      p1_peeks := !p1_peeks - 1)
    else print_endline "";

    let shielded_pos = ref (-1, -1) in
    if !shield then (
      let continue = ref true in
      while continue = ref true do
        print_endline
          "==> At which cooridnates would you like to put a shield that will \
           last 1 round and prevent all damage to the ship located at that \
           position? Enter coordinates in the form of x y";
        let input_level = String.trim (read_line ()) in
        match String.split_on_char ' ' input_level with
        | [ x; y ] -> (
            try
              let xInt = int_of_string x in
              let yInt = int_of_string y in
              if xInt < 10 && xInt > -1 && yInt < 10 && yInt > -1 then
                let () = shielded_pos := (xInt, yInt) in
                continue := false
              else (
                print_endline "==> INVALID COORDINATES, try again";
                continue := true)
            with
            | Failure "int_of_string" ->
                print_endline "==> INVALID COORDINATES, try again";
                continue := true
            | _ ->
                print_endline "==> INVALID COORDINATES, try again";
                continue := true)
      done;
      print_endline "Your grid with shield placed that will last 1 round";
      p1_shields := !p1_shields - 1;
      print_view ~shield_spotIN:!shielded_pos ())
    else print_endline "";

    (* Print out enemy to end game quick COMMENT OUT BOTTOM 2 LINES
    print_Grid (BattleGround.get_board (AIComp.get_board computer_P2));
    PlayerList.list_health (AIComp.get_bag computer_P2); *)

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

    (* Sys.command "clear"; *)
    let shoot_result =
      BattleGround.shoot (AIComp.get_board computer_P2) !x1 !y1
    in

    (*Results of Player 1 shots*)
    let a =
      match shoot_result.shot with
      | true ->
          let () = print_endline "[ You HIT something! ]" in
          let () =
            (BattleGround.get_board p1_tracking_grid).(!x1).(!y1) <-
              BattleGround.Hit
          in
          print_view ~shield_spotIN:!shielded_pos
          (* | false -> let () = print_view() *)
      | false ->
          let () = print_endline "[ You MISSED! :( ]" in
          (BattleGround.get_board p1_tracking_grid).(!x1).(!y1) <-
            BattleGround.Miss;
          print_view ~shield_spotIN:!shielded_pos
    in

    let () = a () in
    (* if AShip.get_health (PlayerList.get_patrolBoat (AIComp.get_bag
       computer_P2)) = 0 then *)
    if PlayerList.all_sunk (AIComp.get_bag computer_P2) = true then
      let _ = Sys.command "clear" in
      let _ =
        print_Grid (BattleGround.get_board (AIComp.get_board computer_P2))
      in
      let _ = print_newline () in
      let _ = Sys.command "clear" in
      let () = print_endline "==> YOU WON!" in
      continue_game := false
    else continue_game := true;

    (* let continue = ref true in Sys.command "clear"; *)
    if continue_game = ref true then (
      print_endline "Computer is shooting... Press enter to continue...";
      String.trim (read_line ());
      AIComp.set_board computer_P2 shoot_result.board_type;
      let ai_shot = !difficulty computer_P2 p1_battle_grid !shielded_pos in

      (* UNCOMMENT TO TEST IF SHIELD PROTECTS THE HEALTH OF A SHIP let ai_shot =
         AIComp.shoot_shield computer_P2 p1_battle_grid !shielded_pos in *)
      if ai_shot.shot then
        match ai_shot.ship_shot with
        | Some a ->
            print_endline ("[ Computer HIT your " ^ AShip.get_type_of_ship a ^ "! ]");
            (* print_view (); *)
            if PlayerList.all_sunk p1_ship_bag = true then
              (* let _ = Sys.command "clear" in *)
              let () = print_endline "==> YOU LOST!" in
              continue_game := false
            else continue_game := true
        | None -> print_endline "==> Unreachable Code"
      else print_endline "[ Computer MISSED! ]";
      print_view ())
    else (* let _ = Sys.command "clear" in *)
      print_endline ""
  done
