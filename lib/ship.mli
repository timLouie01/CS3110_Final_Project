module type ShipClasses = sig
  (* Representation type of a ship *)
  type t

  val get_health : t -> int
  (** [get_health ship1] Returnes: the "health" of the ship1 Health will be = to
      lenght of ship - hits *)

  val get_length : t -> int
  val get_type_of_ship : t -> string
  val get_hits : t -> int
  val build_ship : string -> t
  (* val set_position : t -> int -> int -> int -> int -> unit *)
  val set_position : t -> int -> int -> int -> int -> ((int * int) * bool) list
  val hit_ship : t -> int * int -> int
    
  (* Returns true if the ship has sunk. Returns false if the ship has not sunk. *)
  val get_sunk : t -> bool
  (* Returns a copy of the ship with the sunk element set to true. To be called 
     when the ship is sunk *)
  val set_sunk : t -> t 

  val get_pos : t -> int -> int -> bool

  (* val move_ship : t -> bool *)
end

module AShip : ShipClasses

(* module Carrier:ShipClasses

   module BattleShip:ShipClasses

   module Destroyer:ShipClasses

   module Submarine:ShipClasses

   module PatrolBoat:ShipClasses *)
