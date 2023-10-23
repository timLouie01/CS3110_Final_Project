open Ship
open ShipsBag

(* The signature of the GameBoard *)
module type GameBoard = sig
  type occupy =
    | Ocean
    | Carrier of AShip.t
    | BattleShip of AShip.t
    | Destroyer of AShip.t
    | Submarine of AShip.t
    | PatrolBoat of AShip.t

  type t

  val set_up_board : t
  val place_ship : t -> AShip.t -> int -> int -> int -> int -> bool
  val search_ship : int -> int -> bool
  val shoot : int -> int -> bool
end

module BattleGround : GameBoard = struct
  type occupy =
    | Ocean
    | Carrier of AShip.t
    | BattleShip of AShip.t
    | Destroyer of AShip.t
    | Submarine of AShip.t
    | PatrolBoat of AShip.t

  type t = {
    board : occupy array array;
    size : int;
  }

  let set_up_board = { board = Array.make_matrix 10 10 Ocean; size = 10 }

  let rec check_ocean (x1 : int) (y1 : int) (x2 : int) (y2 : int) : bool =
    failwith "unimplemented"

  let check_valid (length : int) (x1 : int) (y1 : int) (x2 : int) (y2 : int) :
      bool =
    (Int.abs (x1 - x2) = length || Int.abs (y1 - y2) = length)
    && (0 <= x1 && x1 <= 10)
    && (0 <= x2 && x2 <= 10)
    && (0 <= y1 && y1 <= 10)
    && 0 <= y2 && y2 <= 10 && check_ocean x1 y1 x2 y2

  let rec fillerV (b : t) (s : AShip.t) (x : int) (y1 : int) (y2 : int) =
    if y1 = y2 then  b.board.(x).(y1) <- ship
    else
        b.board.(x).(y1) <- AShip. in
      fillerV board ship x (y1 - 1) y2

  let place_ship (board : t) (ship : AShip.t) (x1 : int) (y1 : int) (x2 : int)
      (y2 : int) : bool =
    let check = check_valid (AShip.length ship) x1 y1 x2 y2 in
    if check then
      if x1 = x2 then
        let smaller_Y = min y1 y2 in
        let larger_Y = max y1 y2 in
        filler x1 larger_Y smaller_Y
      else (* t.board.(x1).(y1) <- s in t.board.(x2).(y2) <- s in check *)
        check
    else check

  let search_ship (x : int) (y : int) : bool = failwith "unimplemented"
  (* if t.board.(x1).(y1) <> Ocean then true else false *)

  let shoot (x : int) (y : int) : bool = failwith "unimplemented"
end

(* module BattleGround2:GameBoard = struct include BattleGround1 end *)
