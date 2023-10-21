open Ship
(* The signature of the GameBoard *)
module type GameBoard = sig

  (*  Type representing the GameBoard*)
  type 'a t

  (* Variant Data type at a position *)
  type occupy = Ocean | Carrier of Carrier.t | BattleShip of BattleShip.t | Destroyer of Destroyer.t
  | Submarine of Submarine.t | PatrolBoat of PatrolBoat.t

  (* List of ships already placed on Board*)
  val ships_placed : occupy list

  (* Size of GameBoard *)
  val n: int

  (* Creates GameBoard of length and width = inputted integer
    [set_board l]
      Returns: Returns GameBoard representaiton
      Requires: l >= 10
      SideEffect: sets n = l
      *)
  val set_up_board: int -> 'a t

  (* Given x and y coordinates this funciton checks to see if these positions
     are valid positons in the grid
      Returns: True if 0 <= x < n and 0 <= y < n and False otherwise
        where n = "size" of GameBoard
  *)
  val valid_pos: int -> int -> bool

   (* Given a ship type places the ship with its head at the inputted head coordinate 
      and returns a list of valid positosn for the tail of the given ship type to be
      [place_ship (x) (y)]
      Requires: That the position x,y is a valid and that the ship typed inputted has not already been placed
      position in the graph. Also that ship inputted has not already been placed
      Returns: List of possible locaitons to have the tail of the ship be
      *)
   val ship_positons : occupy -> int -> int -> int list

   (* Given a ship type places the ship with its head at the inputted head coordinate 
      and returns a list of valid positosn for the tail of the given ship type to be
      [place_ship (x) (y)]
      Requires: That the position x,y is a valid
      position in the graph. Also that ship inputted has not already been placed
      Returns: The number of ships left to add to the grid
      *)
    val place_ship : occupy -> int -> int -> int -> int -> int

  (** Given x and y coordinates this funciton searches to see if
      there is a ship at that position in the graph 
      [search_ship x y]
      Requires: That the position x,y is a valid
      position in the graph
      Returns: True if part of a ship is at the inputted positon (x,y) in the
      GameBoard and False otherwise
  *)
  val search_ship: int -> int -> bool


  (** Given x and y coordinates this funciton searches to see if
      there is a ship at that position in the graph and if so shoots/hits
      that part of the ship
      [shoot x y]
      Requires: That the position x,y is a valid
      position in the graph
      Returns: True if part of a ship is at the inputted positon (x,y) in the
      GameBoard and False otherwise
     
  *)
  val shoot: int -> int -> bool


end

module BattleGround:GameBoard
(* module BattleGround2:GameBoard *)