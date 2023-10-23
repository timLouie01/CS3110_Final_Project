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
  val valid_pos : int -> int -> t -> bool
  val ship_positons : occupy -> int -> int -> t -> int list
  val place_ship : occupy -> int -> int -> int -> int -> int
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
    fleet : Player1List.t;
  }

  let set_up_board : t =
    {
      board = Array.make_matrix 10 10 Ocean;
      size = 10;
      fleet = ShipsBag.build_List;
    }

  let valid_pos (x : int) (y : int) (b : t) : bool =
    if b.board.(x).(y) = Ocean then true else false

  let ship_positons (ship : occupy) (x : int) (y : int) (b : t) : int list =
    b.board.(x).(y) = ship in 


  let place_ship (ship : occupy) (x1 : int) (y1 : int) (x2 : int) (y2 : int) :
      int =
    failwith "unimplemented"

  let search_ship (x : int) (y : int) : bool = failwith "unimplemented"
  let shoot (x : int) (y : int) : bool = failwith "unimplemented"
end

(* module BattleGround2:GameBoard = struct include BattleGround1 end *)
