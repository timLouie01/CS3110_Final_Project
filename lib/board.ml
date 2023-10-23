open Ship
(* The signature of the GameBoard *)
module type GameBoard = sig

  type 'a t

  type occupy = Ocean | Carrier of AShip.t | BattleShip of AShip.t | Destroyer of AShip.t
  | Submarine of AShip.t | PatrolBoat of AShip.t

  val ships_placed: occupy list
  val n: int

  val set_up_board: int -> 'a t

  val valid_pos: int -> int -> bool
  
  val ship_positons : occupy -> int -> int -> int list

  val place_ship : occupy -> int -> int -> int -> int -> int

  val search_ship: int -> int -> bool

  val shoot: int -> int -> bool


end

module BattleGround:GameBoard = struct
  type 'a t = 'a array array

  type occupy = Ocean | Carrier of AShip.t | BattleShip of AShip.t | Destroyer of AShip.t
  | Submarine of AShip.t | PatrolBoat of AShip.t
  let ships_placed = []
  let n = 0

  let set_up_board (n' : int) :'a t = Array.make_matrix 10 10 occupy

  let valid_pos(x: int) (y: int): bool = if BattleGround.(x).(y) = Ocean then True else False
  let ship_positons (ship:occupy) (x: int) (y: int): int list = 12

  let place_ship (ship:occupy) (x1: int) (y1: int) (x2: int) (y2: int): int = failwith "unimplemented"

  let search_ship (x: int) (y: int): bool = failwith "unimplemented"
  let shoot (x: int) (y: int): bool = failwith "unimplemented"
end


(* module BattleGround2:GameBoard = struct
  include BattleGround1
end *)



  
