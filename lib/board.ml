 module type GameBoard  = sig
   type 'a t
   type occupy = Ocean | Ship
   val n:int
 
  val set_up_board: int -> 'a t

  val valid_pos: int -> int -> bool

   val place_ship : int -> int -> bool

  val search_ship: int -> int -> bool

  val shoot: int -> int -> bool


end


 module BattleGround:GameBoard = struct
  type 'a t = 'a array array
  
  type occupy = Ocean | Ship

  let n = 0

  let set_up_board (n' : int) :'a t = failwith "unimplemented"

  let valid_pos(x: int) (y: int): bool = failwith "unimplemented"

  let place_ship (x: int) (y: int): bool = failwith "unimplemented"

  let search_ship (x: int) (y: int): bool= failwith "unimplemented"
  let shoot (x: int) (y: int): bool = failwith "unimplemented"
 end

  
