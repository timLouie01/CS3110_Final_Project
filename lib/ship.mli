

   module type ShipClasses = sig
      (* Representation type of a ship *)
      type t
    
      val get_health : t -> int
      (** [get_health ship] Requires: Input ship representation. Returns: the
          "health" of the ship. Health will be = to length of ship - hits on that
          ship.*)
    
      val get_length : t -> int
      (*[get_length ship] Requires: Input ship representation. Returns: number of
        poisitions that the ship takes up.*)
    
      val get_type_of_ship : t -> string
      (*[get_type_of_ship ship] Requires: Input ship representation. Returns: Type
        of the inputted boat as a String. Either Carrier, Battleship, Destroyer,
        Submarine, or patrolBoat.*)
    
      val get_hits : t -> int
      (*[get_hit ship] Requires: Input ship representation. Returns: Number of hits
        that have landed on the specified ship.*)
    
      val build_ship : string -> t
      (**[build_ship str] Requires: The input string is either Carrier, Battleship,
         Destroyer, Submarine, or patrolBoat. Returns: A ship of data type specified
         by the string input.*)
    
      val set_position : t -> int -> int -> int -> int -> ((int * int) * bool) list
      (**[set_position ship x1 y1 x2 y2] Requires: Input ship representation. Both
         coordinates x1,y1 and x2,y2 are valid coordinates on the board. The two
         coordinates are also valid ships positions of ship length apart and
         existing in the same row or column. Returns: List of coordinates of
         positions a ship takes up and a boolean representing whether the position
         has been hit.*)
    
      val hit_ship : t -> int * int -> int
      (** [hit_ship ship x y] Requires: Input ship representation. Coordinates x and
          y are valid positions on the board and are positions where ship occupies.
          Returns: true if the ship has sunk and false if the ship has not sunk. *)
    
      val get_sunk : t -> bool
      (** [get_sunk ship] Requires: Input ship representation Returns: True if all
          positions of the ship has been shot, false otherwise.*)
    
      val get_pos : t -> int -> int -> bool
      (*[get_pos ship x y] Requires: Input ship representation and valid x,y
        coordinates representing a position of the ship. Returns: True if the
        position has been shot, false otherwise.*)
    
      val get_pos_list : t -> ((int * int) * bool) list
      (*[get_pos_list ship] Requires: Input ship representation. Returns: List
        representation of a ship, filled by coordinates of ship positions and
        boolean of whether the position has been shot. *)
    end
    
    module AShip : ShipClasses
    
    (* module Carrier:ShipClasses
    
       module BattleShip:ShipClasses
    
       module Destroyer:ShipClasses
    
       module Submarine:ShipClasses
    
       module PatrolBoat:ShipClasses *)
    