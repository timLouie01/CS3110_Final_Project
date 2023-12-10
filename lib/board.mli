open Ship

(** The signature of the GameBoard type module *)
module type GameBoard = sig
  type t
  (** Type representing the GameBoard*)

  type t' = {
    board_type : t;
    added : bool;
  }
  (** Record field that has a field board_type that holds the gameboard
      representation and a boolean field that is true iff a ship was added to
      the board *)

  type t'' = {
    board_type : t;
    mutable shot : bool;
    ship_shot : AShip.t option;
  }
  (** Record that has fields for the gameboard representation, boolean field to
      reflect wether a ship was shot, and a option field to return None or Some
      a where a is the ship that was shot *)

  type occupy =
    | Ocean
    | Ship of AShip.t
    | Hit
    | Miss  (** Variant Data type at a position *)

  val set_up_board : occupy -> t
  (** [set_up_board] Creates GameBoard of 10x10 dimmensions with every position
      occupied by the Ocean data type. Requires: occupy data type is Ocean.
      Returns: Empty gameBoard representation.*)

  val check_valid : t -> AShip.t -> int -> int -> int -> int -> bool
  (** [check_valid board ship x1 y1 x2 y2] Given a ship type checks that the
      entered coordinates (x1,y1) and (x2,y2) are valid coordiantes on the 10x10
      grid and valid distnaces apart given the length of the inputted ship.
      Additionally checks that all the grid positions that would be filled by
      this ship having its head at the point (x1,y1) and tail at (x2,y2) are
      currenlty "Ocean". Returns: True if having the inputted ship's head at
      (x1,y1) and tail at (x2,y2) is a valid way to place the ship on the
      inputted grid that might have other ships already placed. Otherwise it
      returns false *)

  val place_ship : t -> AShip.t -> int -> int -> int -> int -> t'
  (** [place_ship board ship x1 y1 x2 y2] Places ship on the board between and
      including the specified coordinates. Requires: Coordinates x1, y1 and x2,
      y2 are valid head and tails positions for the specified ship type. (It
      checks by applying the check_valid function) Returns: Record of the Board
      with the ship placed in the inputted positons position and a boolean field
      that is true iff the ship was placed*)

  val shoot : t -> int -> int -> t''
  (** [shoot board x y] Shoots at position x,y on the board. Requires: That the
      position x,y is a valid position in the graph. Returns: Record of the
      board with the shot on the board a boolean field that is true iff the shot
      hit a ship and a field that holds Some ship that was shot or None*)

  val shoot_shield_poss : t -> int -> int -> int -> int -> t''
  (** [shoot_shield_poss board x1 y1 x2 y2] Takes care of shoot when there is a
      shield currently placed on the board. If the shoot is not at the shield
      that call the shoot function otherwise it simply returns a record of the
      board with the shot on the board a boolean field that is set to false
      since the shield blocked the shot field that holds None Requires:
      Coordinate x1, y1 and x2, y2 are valid positions on the board. whether *)

  val get_board : t -> occupy array array
  (** [get_board board] Requires: Input a valid board. Returns: 2D Array of
      board positions and/or states.*)

  val get_pos : t -> int -> int -> occupy
  (** [get_pos board x y] Requires: Input valid coordinate x and y on the board
      Returns: The occupy data type of the coordinate of the board.*)

  val get_added : t' -> bool
  (** [get_added b] Requires: Input valid board of type t' Returns: The boolean
      value stored in record field added of a record b of type t'. *)
end

module BattleGround : GameBoard
(** Module of gameboard type that is used to
    setup each players grid and can take user input for coordinates to shoot at
    and affects ships if necessary. Additionally has a funciton that takes into
    consideration shields if present*)
