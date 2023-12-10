open Board
open ShipsBag
open Ship

(** The signature of the comp type module *)
module type comp = sig

  type t
  (** Representation type of Computer Player *)

  val create_ai : t
  (** Initiates the ai and randomnly place ships to compete against. Outputs the
      AI representation once created. *)

  val set_board_ai : t -> unit
  (** Requires: Input a Sets up the board and adds all 5 ships to the ai's board *)

  val get_board : t -> BattleGround.t
  (** Requires: Input computer player representation type and output their board *)

  val set_board : t -> BattleGround.t -> unit
  (** Requires: Input computer player representation type setup their board by
      playing all 5 ships*)

  val get_bag : t -> PlayerList.t
  (** Requires: Input computer player representation type and output their bag
      of ships*)

  val rand_Move : t -> BattleGround.t -> int * int -> BattleGround.t''
  (** [rand_Move playerBoard] Requires: Input a board. Returns: a new board with
      randomized shoot locations. If the shot hits, the ship and board is
      updated. Otherwise only the board is updated.*)

  val rand1_Move : t -> BattleGround.t -> int * int -> BattleGround.t''
  (** [rand_Move playerBoard] Requires: Input a board. Returns: a new board with
      a shot fired based on current hit and miss locations. If the shot hits,
      the ship and board is updated. Otherwise only the board is updated.*)

  val shoot_shield : t -> BattleGround.t -> int * int -> BattleGround.t''
  (** [shoot_shield playerBoard] Requires: Input a board and shield. Returns: a
      new board with a shot fired at the inputted shield. If the shot hits, the
      ship and board is updated. Otherwise only the board is updated. This
      function was added to help with ease of testing that shields properly
      protected ships during our manual testing/playing the game testing of
      computer and general terminal user interface.*)
end

module AIComp : comp
(** Module that makes the computer pick the computer's next move and has
    functions to initialize the computer opponent's grid *)
