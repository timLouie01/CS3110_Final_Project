open Ship
open ShipsBag

(* The signature of the GameBoard *)
(* My Board = Ocean and Ship and HitShip *)
(* Oppoent Baord = Ocean and Hit misses*)
module type GameBoard = sig
  type occupy =
    | Ocean
    | Ship of AShip.t
    | Hit
    | Miss

  type t

  type t' = {board_type: t; added: bool}
  val set_up_board : occupy -> t

  val check_valid : t -> AShip.t -> int -> int -> int -> int -> bool
  val place_ship : t -> AShip.t -> int -> int -> int -> int -> t'
  type t'' = {board_type: t; mutable shot: bool; ship_shot: AShip.t option}
  val shoot : t -> int -> int -> t''
  val shoot_shield_poss : t -> int -> int -> int -> int -> t''
  val get_board : t -> occupy array array
  val get_pos : t -> int -> int -> occupy
end

module BattleGround : GameBoard = struct
  type occupy =
    | Ocean
    | Ship of AShip.t
    | Hit
    | Miss

  type t = {
    board : occupy array array;
    size : int;
  }

  type t' = {board_type: t; added: bool}

  type t'' = {board_type: t; mutable shot: bool; ship_shot: AShip.t option}
  let set_up_board (fill_type:occupy): t = { board = Array.make_matrix 10 10 fill_type; size = 10 }

  let rec check_oceanV (b : t) (s : AShip.t) (x : int) (y1 : int) (y2 : int) :
      bool =
    if y1 = y2 then b.board.(x).(y1) = Ocean
    else b.board.(x).(y1) = Ocean && check_oceanV b s x (y1 - 1) y2

  let rec check_oceanH (b : t) (s : AShip.t) (y : int) (x1 : int) (x2 : int) :
      bool =
    if x1 = x2 then b.board.(x1).(y) = Ocean
    else b.board.(x1).(y) = Ocean && check_oceanH b s y (x1 + 1) x2

  let check_valid (b : t) (s : AShip.t) (x1 : int) (y1 : int) (x2 : int)
      (y2 : int) : bool =
    (Int.abs (x1 - x2) + 1 = AShip.get_length s
    || Int.abs (y1 - y2) + 1 = AShip.get_length s)
    && (0 <= x1 && x1 < 10)
    && (0 <= x2 && x2 < 10)
    && (0 <= y1 && y1 < 10)
    && 0 <= y2 && y2 < 10
    &&
    (if x1 = x2 then check_oceanV b s x1 (Int.max y1 y2) (Int.min y1 y2)
    else check_oceanH b s y1 (Int.min x1 x2) (Int.max x1 x2))

  let rec fillerV (b : t) (s : AShip.t) (x : int) (y1 : int) (y2 : int) :
      occupy array array =
    (* print_endline(string_of_int(x) ^ string_of_int(y1)); *)
    if y1 = y2 then
      let () = b.board.(x).(y1) <- Ship s in
      b.board
    else
      let () = b.board.(x).(y1) <- Ship s in
      fillerV b s x (y1 - 1) y2

  let rec fillerH (b : t) (s : AShip.t) (y : int) (x1 : int) (x2 : int) :
      occupy array array =
    if x1 = x2 then
      let () = b.board.(x1).(y) <- Ship s in
      b.board
    else
      let () = b.board.(x1).(y) <- Ship s in
      fillerH b s y (x1 + 1) x2

  let place_ship (b : t) (s : AShip.t) (x1 : int) (y1 : int) (x2 : int)
      (y2 : int) : t'=
    let pos = AShip.set_position s x1 y1 x2 y2 in
    let check = check_valid b s x1 y1 x2 y2 in
    if check then
      if x1 = x2 then
        let smaller_Y = min y1 y2 in
        let larger_Y = max y1 y2 in
        {board_type = { board = fillerV b s x1 larger_Y smaller_Y; size = b.size }; added = true}
      else
        let smaller_x = min x1 x2 in
        let larger_X = max x1 x2 in
        { board_type = {board = fillerH b s y1 smaller_x larger_X; size = b.size }; added = true}
    else {board_type = b; added = false}

  let shoot (b : t) (x : int) (y : int) : t'' =
    match b.board.(x).(y) with
    | Ocean -> let () = b.board.(x).(y) <- Miss in
      {board_type = b; shot = false; ship_shot = None }
    | Ship a ->
        let health = AShip.hit_ship a (x, y) in
        let () = b.board.(x).(y) <- Hit in
        {board_type = b;shot =  true; ship_shot = Some a}
    | Hit -> let () = b.board.(x).(y) <- Miss in {board_type = b; shot = false;ship_shot = None}
    | Miss -> let () = b.board.(x).(y) <- Miss in {board_type = b; shot = false; ship_shot = None}
  
  let shoot_shield_poss (b : t) (x : int) (y : int) (xs: int)(ys: int) : t'' =
  if (x = xs) && (y = ys) then 
    {board_type = b;shot = false; ship_shot = None}
  else
    shoot(b)(x)(y)

  let get_board (b : t) : occupy array array = b.board
  let get_pos (b : t) (x : int) (y : int) : occupy = b.board.(x).(y)
end

(* module BattleGround2:GameBoard = struct include BattleGround1 end *)
