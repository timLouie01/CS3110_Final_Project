open Ship
module type PlayerListOfShips = sig

  (* Representaiton type of list of ships *)
  type t

  (* Remove carrier ship from list *)
  val remove_Carrier: Carrier.t -> bool
end

module Player1List:PlayerListOfShips