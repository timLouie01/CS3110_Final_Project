module type ShipClasses = sig
  (* Representation type of a ship *)
  type t

  val get_health : t -> int
  (** [get_health ship1] Returnes: the "health" of the ship1 Health will be = to
      lenght of ship - hits *)

  val get_length : t -> int
  val get_type_of_Ship : t -> string
  val get_hits : t -> int
  val build_ship : string -> t
  val set_position : t -> int -> int -> int -> int -> ((int * int) * bool) list
  val hit_ship : t -> int * int -> int

  (* val move_ship : t -> bool *)
end

module AShip : ShipClasses

(* module Carrier:ShipClasses

   module BattleShip:ShipClasses

   module Destroyer:ShipClasses

   module Submarine:ShipClasses

   module PatrolBoat:ShipClasses *)
