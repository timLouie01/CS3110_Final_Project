open Ship
module T = ANSITerminal
open Printf

module type PlayerListOfShips = sig

  type t

  val build_bag :int -> t

  val get_Carrier : t -> AShip.t
  val get_Battleship : t -> AShip.t
  val get_Destroyer: t -> AShip.t
  val get_Submarine:t -> AShip.t
  val get_patrolBoat: t -> AShip.t

  (* val remove_ship : t -> AShip.t -> t *)

  val list_health : t -> unit

  val all_sunk: t -> bool

end

(* The bag of ships alloted to player 1. Players start with one of each ship.
   Ships will be removed from the bag when all spots on the ship are hit (i.e. 
   the ship has sunk). *)
module PlayerList:PlayerListOfShips = struct

  type t = {mutable carrier : AShip.t ; mutable battleship: AShip.t ; mutable destroyer : AShip.t ;
  mutable submarine : AShip.t; mutable patrolBoat : AShip.t}

  let build_bag (num_ships:int): t =
    let carrier = AShip.build_ship("Carrier") in 
    let battleship = AShip.build_ship("Battleship") in
    let destroyer= AShip.build_ship("Destroyer") in 
    let submarine = AShip.build_ship("Submarine") in 
    let patrolBoat = AShip.build_ship("Patrol Boat") in 
      {carrier = carrier; battleship = battleship; destroyer = destroyer; submarine = submarine; patrolBoat = patrolBoat}
  
  let get_Carrier (bag: t):AShip.t = 
    bag.carrier
  let get_Battleship (bag: t):AShip.t = 
    bag.battleship
  let get_Destroyer (bag: t):AShip.t = 
    bag.destroyer
  let get_Submarine (bag: t):AShip.t = 
    bag.submarine
  let get_patrolBoat (bag: t):AShip.t = 
    bag.patrolBoat

  (* let remove_ship (player_ships : t) (sunk_ship : AShip.t) : t = 
    let ship_type = AShip.get_type_of_ship sunk_ship  in 
      match ship_type with 
      | "Carrier" -> {player_ships with carrier = (AShip.set_sunk sunk_ship)} 
      | "Battleship" -> {player_ships with battleship = (AShip.set_sunk sunk_ship)} 
      | "Destroyer" -> {player_ships with destroyer = (AShip.set_sunk sunk_ship)} 
      | "Submarine" -> {player_ships with submarine = (AShip.set_sunk sunk_ship)} 
      | _ -> {player_ships with patrolBoat = (AShip.set_sunk sunk_ship)}  *)

  let list_health (bag: t) : unit = 
    T.print_string [T.Bold; Foreground Green] "------------ \n";
    T.print_string [T.Bold; Foreground Green] "     + ";
    print_endline("Carrier Ship Health " 
      ^ string_of_int(AShip.get_health(bag.carrier)) ^ " of 5");
    T.print_string [T.Bold; Foreground Green] "     + ";
    print_endline("Battleship Ship Health " 
      ^ string_of_int(AShip.get_health(bag.battleship))^ " of 4");
      T.print_string [T.Bold; Foreground Green] "     + ";
    print_endline("Destroyer Ship Health " 
      ^ string_of_int(AShip.get_health(bag.destroyer))^ " of 3");
      T.print_string [T.Bold; Foreground Green] "     + ";
    print_endline("Submarine Ship Health " 
      ^ string_of_int(AShip.get_health(bag.submarine))^ " of 3");
      T.print_string [T.Bold; Foreground Green] "     + ";
    print_endline("Patrol Boat Ship Health " 
      ^ string_of_int(AShip.get_health(bag.patrolBoat))^ " of 2");
    T.print_string [T.Bold; Foreground Green] "------------ \n"

  let all_sunk (bag: t) : bool = 
    let list_to_check = [bag.carrier; bag.battleship; bag.destroyer; bag.submarine; bag.patrolBoat] in
    let rec check (funct_list: (AShip.t) list ) : bool =
      match funct_list with
      | a ::t  -> if ((AShip.get_health(a)) = 0) then check (t) else false
      | [] -> true in
    if (check (list_to_check)) then true
    else false
  end