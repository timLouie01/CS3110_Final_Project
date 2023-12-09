
open Ship

module type PlayerListOfShips = sig
  (* Representaiton type of player's collection of ships *)
  type t

  val build_bag : int -> t

  (* Builds a record of each of the players ships from a list of ships.*)

  val get_Carrier : t -> AShip.t
  val get_Battleship : t -> AShip.t
  val get_Destroyer : t -> AShip.t
  val get_Submarine : t -> AShip.t
  val get_patrolBoat : t -> AShip.t

  val list_health : t -> unit
  (** [list_health listofships] Requires: Input a bag of ships. Returns: Print
      out health of all ships *)

  val all_sunk : t -> bool
  (** [all_sunk listofships] Requires: Input a bag of ships. Returns: true if
      all ships are sunk, false otherwise. *)
end

module PlayerList : PlayerListOfShips
