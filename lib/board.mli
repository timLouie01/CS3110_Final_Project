
open Ship

(* The signature of the GameBoard *)
module type GameBoard = sig
  (* Type representing the GameBoard*)
  type t

  type t' = {
    board_type : t;
    added : bool;
  }

  type t'' = {
    board_type : t;
    mutable shot : bool;
    ship_shot : AShip.t option;
  }

  (* Variant Data type at a position *)
  type occupy =
    | Ocean
    | Ship of AShip.t
    | Hit
    | Miss

  val set_up_board : occupy -> t
  (** [set_up_board] Creates GameBoard of 10x10 dimmensions with every position
      occupied by the Ocean data type. Requires: occupy data type is Ocean.
      Returns: Empty gameBoard representation.*)

  val check_valid : t -> AShip.t -> int -> int -> int -> int -> bool
  (** [check_valid board ship x y] Given a ship type places the ship with its
      head at the inputted head coordinate and returns a list of valid positions
      for the tail of the given ship type to be [place_ship (x) (y)] Requires:
      That the position x,y is a valid position in the graph. Also that ship
      inputted has not already been placed Returns: The number of ships left to
      add to the grid *)

  val place_ship : t -> AShip.t -> int -> int -> int -> int -> t'
  (** [place_ship board ship x1 y1 x2 y2] Places ship on the board between and
      including the specified coordinates. Requires: Coordinates x1, y1 and x2,
      y2 are valid head and tails positions for the specified ship type.
      Returns: Board with the ship placed in position.*)

  val shoot : t -> int -> int -> t''
  (** [shoot board x y] Shoots at position x,y on the board. Requires: That the
      position x,y is a valid position in the graph. Returns: a board with the
      shot on the board.*)

  val shoot_shield_poss : t -> int -> int -> int -> int -> t''
  (** [shoot_shield_poss board x1 y1 x2 y2] Checks if the position shot at is
      the same position being shielded in that round. Requires: Coordinate x1,
      y2 and x2, y2 are valid positions on the board. Returns: *)

  val get_board : t -> occupy array array
  (** [get_board board] Requires: Input a valid board. Returns: 2D Array of
      board positions and/or states.*)

  val get_pos : t -> int -> int -> occupy
  (** [get_pos board x y] Requires: Input valid coordinate x and y on the board
      Returns: The occupy data type of the coordinate of the board.*)

  val get_added : t' -> bool
  (** [get_added b] Requires: Input valid board of type t'
      Returns: The boolean value stored in record field added of a record b
      of type t'. *)

end

module BattleGround : GameBoard
(* module BattleGround2:GameBoard *)
