open Ship
open ShipsBag

(* The signature of the GameBoard *)
module type GameBoard = sig
  type occupy =
    | Ocean
    | Ship of AShip.t

  type t

  val set_up_board : t

  val place_ship :
    t -> AShip.t -> int -> int -> int -> int -> t
  val search_ship : int -> int -> bool
  val shoot : int -> int -> bool
  val get_board :t -> occupy array array
  val get_pos: t -> int -> int -> occupy

end

module BattleGround : GameBoard = struct
  type occupy =
    | Ocean
    | Ship of AShip.t
  (* | Carrier of AShip.t | BattleShip of AShip.t | Destroyer of AShip.t |
     Submarine of AShip.t | PatrolBoat of AShip.t *)

  type t = {
    board : occupy array array;
    size : int;
  }

  let set_up_board :t = { board = Array.make_matrix 10 10 Ocean; size = 10 }

  let rec check_ocean (x1 : int) (y1 : int) (x2 : int) (y2 : int) : bool =
    failwith "unimplemented"

  let check_valid (length : int) (x1 : int) (y1 : int) (x2 : int) (y2 : int) :
      bool =
    (Int.abs (x1 - x2) = length || Int.abs (y1 - y2) = length)
    && (0 <= x1 && x1 <= 10)
    && (0 <= x2 && x2 <= 10)
    && (0 <= y1 && y1 <= 10)
    && 0 <= y2 && y2 <= 10 && check_ocean x1 y1 x2 y2

  let rec fillerV (b : t) (s : AShip.t) (x : int) (y1 : int) (y2 : int) :
      occupy array array =
    (* b.board.(0).(0) <- (Ship s) *)
    if y1 = y2 then
      let () = b.board.(x).(y1) <- Ship s in
      b.board
    else
      let () = b.board.(x).(y1) <- Ship s in
      fillerV b s x (y1 - 1) y2

  let rec fillerH (b : t) (s : AShip.t) (y : int) (x1 : int) (x2 : int) :
      occupy array array =
    (* b.board.(0).(0) <- (Ship s) *)
    if x1 = x2 then
      let () = b.board.(x1).(y) <- Ship s in
      b.board
    else
      let () = b.board.(x1).(y) <- Ship s in
      fillerV b s y (x1 + 1) x2

  let place_ship (b : t) (s : AShip.t) (x1 : int) (y1 : int) (x2 : int)
      (y2 : int) : t =
    let check = check_valid (AShip.get_length s) x1 y1 x2 y2 in
    if check then
      if x1 = x2 then
        let smaller_Y = min y1 y2 in
        let larger_Y = max y1 y2 in
        {board = fillerV b s x1 larger_Y smaller_Y; size = b.size}
      else
        let smaller_x = min x1 x2 in
        let larger_X = max x1 x2 in
        {board = fillerH b s y1 smaller_x larger_X; size =b.size}
    else b

  let get_board (b : t) :occupy array array = 
    b.board
    
  let get_pos (b : t) (x : int) (y : int) :
  occupy = b.board.(x).(y)

  let search_ship (x : int) (y : int) : bool = failwith "unimplemented"
  (* if t.board.(x1).(y1) <> Ocean then true else false *)

  let shoot (x : int) (y : int) : bool = failwith "unimplemented"
end

(* module BattleGround2:GameBoard = struct include BattleGround1 end *)
