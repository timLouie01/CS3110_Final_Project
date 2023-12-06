open Ship
module type PlayerListOfShips = sig

  (* Representaiton type of player's collection of ships *)
  type t 

  val build_bag :int -> t

  (* Builds a record of each of the players ships from a list of ships.  *)
  (* val build_bag : t *)

  val get_Carrier : t -> AShip.t
  val get_Battleship : t -> AShip.t
  val get_Destroyer: t -> AShip.t
  val get_Submarine:t -> AShip.t
  val get_patrolBoat: t -> AShip.t

  (* Removes a ship from a record documenting of each of the players ships.  *)
  (* val remove_ship : t -> AShip.t -> t *)

  (* List out health of all ships *)
  val list_health : t -> unit

  (* Returns true iff all ships are sunk *)
  val all_sunk: t -> bool

end

module PlayerList:PlayerListOfShips
