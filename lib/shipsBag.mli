open Ship

(** The signature of the PlayerListOfShips type module *)
module type PlayerListOfShips = sig
    
  type t
  (** Representaiton type of player's collection of ships *)

  val build_bag : int -> t
  (** Requires: input number of ships to add to bag Returns: the bag of ships *)

  val get_Carrier : t -> AShip.t
  (** Requires: input bag of ships and outputs the carrier type ship in the bag*)

  val get_Battleship : t -> AShip.t
  (** Requires: input bag of ships and outputs the battleship type ship in the
      bag*)

  val get_Destroyer : t -> AShip.t
  (** Requires: input bag of ships and outputs the destroyer type ship in the
      bag*)

  val get_Submarine : t -> AShip.t
  (** Requires: input bag of ships and outputs the submarine type ship in the
      bag*)

  val get_patrolBoat : t -> AShip.t
  (** Requires: input bag of ships and outputs the patrol boat type ship in the
      bag*)

  val list_health : t -> unit
  (** [list_health listofships] Requires: Input a bag of ships. Returns: Print
      out health of all ships *)

  val all_sunk : t -> bool
  (** [all_sunk listofships] Requires: Input a bag of ships. Returns: true if
      all ships are sunk, false otherwise. *)
end

module PlayerList : PlayerListOfShips
(** Module that has functions to initialize the bag of 5 ships for a player and
    functions to access these ships in the bag. Also this module has the ability
    to check if all the ships in the bag are sunk. *)
