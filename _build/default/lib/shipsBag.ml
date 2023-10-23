open Ship
module type PlayerListOfShips = sig

  type t

  val build_list : t

  val remove_ship : t -> AShip.t -> t

end

(* The bag of ships alloted to player 1. Players start with one of each ship.
   Ships will be removed from the bag when all spots on the ship are hit (i.e. 
   the ship has sunk). *)
module Player1List:PlayerListOfShips = struct

  type t = {carrier : AShip.t ; battleship: AShip.t ; destroyer : AShip.t ;
  submarine : AShip.t; patrolBoat : AShip.t}

  let build_list : t =
    let carrier = AShip.build_ship("Carrier") in 
    let battleship = AShip.build_ship("Battleship") in
    let destroyer= AShip.build_ship("Destoryer") in 
    let submarine = AShip.build_ship("Submarine") in 
    let patrolBoat = AShip.build_ship("Patrol Boat") in 
      {carrier = carrier; battleship = battleship; destroyer = destroyer; submarine = submarine; patrolBoat = patrolBoat}
  
  let remove_ship (player_ships : t) (sunk_ship : AShip.t) : t = failwith "unimplemented"

end