module type ShipClasses = sig
  (* Representation type of a ship *)
  type t

  val build_ship : string -> t

  val health : t -> int
  (** [health ship1] Returnes: the "health" of the ship1 Health will be = to
      lenght of ship - hits *)

  val length : t -> int
  val ship_Type : t -> string
  val move_ship : t -> bool
end

module AShip : ShipClasses

(* module Carrier:ShipClasses

   module BattleShip:ShipClasses

   module Destroyer:ShipClasses

   module Submarine:ShipClasses

   module PatrolBoat:ShipClasses *)
