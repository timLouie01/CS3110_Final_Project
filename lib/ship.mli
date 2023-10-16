module type ShipClasses = sig
  
  (* Representation type of a ship *)
  type t

  (* Tracking number of hits ship has taken *)
  val hits : int
  
  (** [health ship1]
  Returnes: the "health" of the ship1
      Health will be = to lenght of ship - hits 
       *)
  val health : t -> int



end

module Carrier:ShipClasses

module BattleShip:ShipClasses

module Destroyer:ShipClasses

module Submarine:ShipClasses

module PatrolBoat:ShipClasses