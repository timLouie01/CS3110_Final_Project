(* The signature of the GameBoard *)
module type GameBoard = sig

  (*  Type representing the GameBoard*)
  type 'a t

  (* Variant Data type at a position *)
  type occupy = Ocean | Ship

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

   (* Given a ship places a ship at the *)
   val place_ship : int -> int -> bool

  (** Given x and y coordinates this funciton searches to see if
      there is a ship at that position in the graph 
      [search_ship x y]
      Returns: True if part of a ship is at the inputted positon (x,y) in the
      GameBoard and False otherwise
      Requires: That the position x,y is a valid
      position in the graph
  *)
  val search_ship: int -> int -> bool


  (** Given x and y coordinates this funciton searches to see if
      there is a ship at that position in the graph and if so shoots/hits
      that part of the ship
      [shoot x y]
      Returns: True if part of a ship is at the inputted positon (x,y) in the
      GameBoard and False otherwise
      Requires: That the position x,y is a valid
      position in the graph
  *)
  val shoot: int -> int -> bool


end

module BattleGround:GameBoard