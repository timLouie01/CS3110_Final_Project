open Ship
module type PlayerListOfShips = sig

  (* Representaiton type of list of ships *)
  type t = {carrier : AShip.t ; battleship: AShip.t ; destroyer : AShip.t ;
  submarine : AShip.t; patrolBoat : AShip.t}

  val build_List : AShip.t list -> t


end

module Player1List:PlayerListOfShips
