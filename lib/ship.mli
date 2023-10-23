module type ShipClasses = sig
  
  (* Representation type of a ship *)
  type t

  (* Tracking number of hits ship has taken *)
  (* val hits : int *)
  
  (* Trachking number of nonhit position of a ship *)
  (* val non_Hit : int *)

  (* Trachking length *)
  (* val length: int *)

  (** [health ship1]
  Returnes: the "health" of the ship1
      Health will be = to lenght of ship - hits 
       *)
  val health : t -> int


  val move_ship: t -> bool 

  val set_Length : t -> int  -> bool

  val build_ship: int -> t



  
end

module AShip:ShipClasses

(* module Carrier:ShipClasses

module BattleShip:ShipClasses

module Destroyer:ShipClasses

module Submarine:ShipClasses

module PatrolBoat:ShipClasses *)