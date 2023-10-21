open Ship
(* The signature of the GameBoard *)
module type GameBoard = sig

  type 'a t

  type occupy = Ocean | Carrier of Carrier.t | BattleShip of BattleShip.t | Destroyer of Destroyer.t
  | Submarine of Submarine.t | PatrolBoat of PatrolBoat.t

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

  type occupy = Ocean | Carrier of Carrier.t | BattleShip of BattleShip.t | Destroyer of Destroyer.t
  | Submarine of Submarine.t | PatrolBoat of PatrolBoat.t
  let ships_placed = []
  let n = 0

  let set_up_board (n' : int) :'a t = failwith "unimplemented"

  let valid_pos(x: int) (y: int): bool = failwith "unimplemented"
  let ship_positons (ship:occupy) (x: int) (y: int): int list = failwith "unimplemented"

  let place_ship (ship:occupy) (x1: int) (y1: int) (x2: int) (y2: int): int = failwith "unimplemented"

  let search_ship (x: int) (y: int): bool= failwith "unimplemented"
  let shoot (x: int) (y: int): bool = failwith "unimplemented"
end


(* module BattleGround2:GameBoard = struct
  include BattleGround1
end *)



  
