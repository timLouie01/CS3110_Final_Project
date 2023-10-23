open Ship
module type PlayerListOfShips = sig

  type t

  val build_list : AShip.t list -> t

  val remove_ship : t -> AShip.t -> t

end

(* The bag of ships alloted to player 1. Players start with one of each ship.
   Ships will be removed from the bag when all spots on the ship are hit (i.e. 
   the ship has sunk). *)
module Player1List:PlayerListOfShips = struct

  type t = {carrier : AShip.t ; battleship: AShip.t ; destroyer : AShip.t ;
  submarine : AShip.t; patrolBoat : AShip.t}

  let build_list (ship: AShip.t list): t =
    let carrier = AShip.build_ship(5) in 
    let battleship = AShip.build_ship(4) in
    let destroyer= AShip.build_ship(3) in 
    let submarine = AShip.build_ship(3) in 
    let patrolBoat = AShip.build_ship(2) in 
      {carrier = carrier; battleship = battleship; destroyer = destroyer; submarine = submarine; patrolBoat = patrolBoat}
  
  let remove_ship (player_ships : t) (sunk_ship : AShip.t) : t =

end