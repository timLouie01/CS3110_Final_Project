open Ship
module type PlayerListOfShips = sig

  type t = {carrier : AShip.t ; battleship: AShip.t ; destroyer : AShip.t ;
  submarine : AShip.t; patrolBoat : AShip.t}
  val build_List : AShip.t list -> t

end

module Player1List:PlayerListOfShips = struct

  type t = {carrier : AShip.t ; battleship: AShip.t ; destroyer : AShip.t ;
  submarine : AShip.t; patrolBoat : AShip.t}

  (* let ship_bag = {carrier = Carrier.t ; battleship = BattleShip.t ; destoryer = Destroyer.t ;
  submarine = Submarine.t ; patrolBoat = PatrolBoat.t} *)

  let build_List (ship: AShip.t list): t =
  (* output = {carrier = AShip.t ; battleship = BattleShip.t ; destroyer = Destroyer.t ;
  submarine = Submarine.t ; patrolBoat = PatrolBoat.t} *)
   let carrier = AShip.build_ship(5) in 
   let battleship = AShip.build_ship(4) in
   let destroyer= AShip.build_ship(3) in 
   let submarine = AShip.build_ship(3) in 
   let patrolBoat = AShip.build_ship(2) in 

   {carrier = carrier; battleship = battleship; destroyer = destroyer; submarine = submarine; patrolBoat = patrolBoat}
   
end