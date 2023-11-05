open Board
open ShipsBag
open Ship

module type comp = sig
  type t

  val rand_Move : t -> BattleGround.t -> bool
  (** [rand_Move playerBoard] Returns: a new board with randomized shoot
      locations. If the shot hits, the ship and board is updated. Otherwise only
      the board is updated.*)

  val rand1_Move : t -> BattleGround.t -> bool
  (** [rand_Move playerBoard] Returns: a new board with a shot fired based on
      current hit and miss locations. If the shot hits, the ship and board is
      updated. Otherwise only the board is updated.*)
end
