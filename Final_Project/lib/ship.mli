module type ShipClasses = sig
  
  (* Representation type of a ship *)
  type t

  (* Tracking number of hits ship has taken *)
  val hits : int
  
  (** Returnes the "health" of a ship
      Health will be = to lenght of ship - hits  *)
  val health : t -> int



end

module Carrier:ShipClasses

module BattleShip:ShipClasses

module Destroyer:ShipClasses

module Submarine:ShipClasses

module PatrolBoat:ShipClasses