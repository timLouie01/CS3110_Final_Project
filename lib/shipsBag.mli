open Ship
module type PlayerListOfShips = sig

  (* Representaiton type of player's collection of ships *)
  type t 

  (* Builds a record of each of the players ships from a list of ships.  *)
  val build_list : t

  (* Removes a ship from a record documenting of each of the players ships.  *)
  val remove_ship : t -> AShip.t -> t

end

module Player1List:PlayerListOfShips
