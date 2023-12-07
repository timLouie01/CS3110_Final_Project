open Board
open ShipsBag
open Ship

module type comp = sig
  type t

  val create_ai : t
  val set_board_ai : t -> unit
  val get_board : t -> BattleGround.t
  val set_board : t -> BattleGround.t -> unit
  val get_bag : t -> PlayerList.t
  val rand_Move : t -> BattleGround.t -> BattleGround.t''
  val rand1_Move : t -> BattleGround.t -> BattleGround.t''
end

module AIComp : comp = struct
  type t = {
    mutable hits : (int * int) list;
    mutable misses : (int * int) list;
    mutable board : BattleGround.t;
    mutable ship_bag : PlayerList.t;
  }

  let ships_to_place =
    [
      ("Carrier", 5, PlayerList.get_Carrier);
      ("Battleship", 4, PlayerList.get_Battleship);
      ("Destroyer", 3, PlayerList.get_Destroyer);
      ("Submarine", 3, PlayerList.get_Submarine);
      ("Patrol Boat", 2, PlayerList.get_patrolBoat);
    ]

  let tail_direction (x1 : int) (y1 : int) (direciton : int) (ship_length : int)
      : int * int =
    (* 0 = North 1 = East 2 = South 3 = West*)
    match direciton with
    | 0 ->
        let x2 = x1 in
        let y2 = y1 - ship_length - 1 in
        (x2, y2)
    | 1 ->
        let x2 = x1 + ship_length - 1 in
        let y2 = y1 in
        (x2, y2)
    | 2 ->
        let x2 = x1 in
        let y2 = y1 + ship_length - 1 in
        (x2, y2)
    | 3 ->
        let x2 = x1 - ship_length - 1 in
        let y2 = y1 in
        (x2, y2)
    | _ -> (0, 0)

  let rec valid_pos (board_input : BattleGround.t) (ship : AShip.t) :
      (int * int) * (int * int) =
    let () = Random.self_init () in
    let x1 = Random.int 10 in
    let y1 = Random.int 10 in
    let tail_direction_num = Random.int 4 in
    let tail_pos =
      tail_direction x1 y1 tail_direction_num (AShip.get_length ship)
    in
    match tail_pos with
    | end_x, end_y ->
        if BattleGround.check_valid board_input ship x1 y1 end_x end_y then
          ((x1, y1), (end_x, end_y))
        else valid_pos board_input ship

  let rec set_up_board_help
      (ships_list : (string * int * (PlayerList.t -> AShip.t)) list)
      (board_input : BattleGround.t) (bag_input : PlayerList.t) : BattleGround.t
      =
    match ships_list with
    | (ship_name, length, get_function) :: t -> (
        let ship_to_place = bag_input |> get_function in
        let pos = valid_pos board_input (bag_input |> get_function) in
        match pos with
        | (x1, y1), (x2, y2) ->
            let new_board =
              BattleGround.place_ship board_input ship_to_place x1 y1 x2 y2
            in
            set_up_board_help t new_board.board_type bag_input)
    | [] -> board_input

  let create_ai : t =
    {
      hits = [];
      misses = [];
      board = BattleGround.set_up_board BattleGround.Ocean;
      ship_bag = PlayerList.build_bag 5;
    }

  let set_board_ai (input : t) : unit =
    input.board <- set_up_board_help ships_to_place input.board input.ship_bag

  let get_board (input_record : t) : BattleGround.t = input_record.board
  let get_bag (input_record : t) : PlayerList.t = input_record.ship_bag

  let set_board (input_record : t) (board : BattleGround.t) : unit =
    input_record.board <- board

  let ai_shoot (v : BattleGround.t) (c : t) (x : int) (y : int) :
      BattleGround.t'' =
    let result = BattleGround.shoot v x y in
    let _ =
      if result.shot then c.hits <- (x, y) :: c.hits
      else c.misses <- (x, y) :: c.misses
    in
    result

  let rand_Move (c : t) (opponent : BattleGround.t) : BattleGround.t'' =
    let x = Random.int 10 in
    let y = Random.int 10 in
    print_string
      ("[ The computer shot at " ^ string_of_int x ^ " " ^ string_of_int y ^ " ");
    ai_shoot opponent c x y

  let rec rand1_Move (c : t) (opponent : BattleGround.t) : BattleGround.t'' =
    if List.length c.hits = 0 then rand_Move (c : t) (opponent : BattleGround.t)
    else if Random.int 2 = 1 then rand_Move (c : t) (opponent : BattleGround.t)
    else
      let coor = List.nth c.hits (Random.int (List.length c.hits)) in
      let direction = Random.int 4 in

      let new_coor =
        match direction with
        | 0 -> (
            match coor with
            | x, y -> (x - 1, y))
        | 1 -> (
            match coor with
            | x, y -> (x + 1, y))
        | 2 -> (
            match coor with
            | x, y -> (x, y - 1))
        | 3 -> (
            match coor with
            | x, y -> (x, y + 1))
        | _ -> coor
      in

      let x1 =
        match new_coor with
        | o, _ -> o
      in
      let y1 =
        match new_coor with
        | _, p -> p
      in
      if x1 > 10 || x1 < 0 || y1 > 10 || y1 < 0 then rand_Move c opponent
      else
        match BattleGround.get_pos opponent x1 y1 with
        | Hit -> rand1_Move c opponent
        | Miss -> rand1_Move c opponent
        | _ -> ai_shoot opponent c x1 y1
end