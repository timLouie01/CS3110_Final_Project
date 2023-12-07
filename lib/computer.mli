open Board
open ShipsBag
open Ship

module type comp = sig
  type t 
  val create_ai:t 
  (* Create the ai and randomnly place ships to compete against *)

  val set_board_ai: t -> unit

  val get_board: t-> BattleGround.t

  val set_board: t -> BattleGround.t -> unit

  val get_bag: t -> PlayerList.t


  (* val rand_Move : t -> BattleGround.t -> BattleGround.t''
  (** [rand_Move playerBoard] Returns: a new board with randomized shoot
      locations. If the shot hits, the ship and board is updated. Otherwise only
      the board is updated.*)

  val rand1_Move : t -> BattleGround.t -> BattleGround.t''
  (** [rand_Move playerBoard] Returns: a new board with a shot fired based on
      current hit and miss locations. If the shot hits, the ship and board is
      updated. Otherwise only the board is updated.*) *)
end

module AIComp : comp 
