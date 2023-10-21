open Ship
module type PlayerListOfShips = sig

  (* Representaiton type of list of ships *)
  type t

  (* val setUp:t-> bool *)
end

module Player1List:PlayerListOfShips

module Player2List:PlayerListOfShips