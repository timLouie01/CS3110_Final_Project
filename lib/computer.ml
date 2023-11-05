open Board
open ShipsBag
open Ship

module type comp = sig
  type t

  val rand_Move : t -> BattleGround.t -> bool
  val rand1_Move : t -> BattleGround.t -> bool
end

module AIComp : comp = struct
  type t = {
    mutable hits : (int * int) list;
    mutable misses : (int * int) list;
  }

  let ai_shoot (v : BattleGround.t) (c : t) (x : int) (y : int) : bool =
    let result = BattleGround.shoot v x y in
    let _ =
      if result then c.hits <- (x, y) :: c.hits
      else c.misses <- (x, y) :: c.misses
    in
    result

  let rand_Move (c : t) (v : BattleGround.t) : bool =
    let x = Random.int 10 in
    let y = Random.int 10 in
    ai_shoot v c x y

  let rec rand1_Move (c : t) (v : BattleGround.t) : bool =
    let coor = List.nth c.hits (Random.int (List.length c.hits)) in
    let direction = Random.int 4 in
    let new_coor =
      match direction with
      | 0 -> (
          match coor with
          | x, y -> (x - 1, y))
      | 1 -> (
          match coor with
          | x, y -> (x + 1, y))
      | 2 -> (
          match coor with
          | x, y -> (x, y - 1))
      | 3 -> (
          match coor with
          | x, y -> (x, y + 1))
      | _ -> coor
    in
    let x =
      match new_coor with
      | o, _ -> o
    in
    let y =
      match new_coor with
      | _, p -> p
    in
    match BattleGround.get_pos v x y with
    | Hit -> rand1_Move c v
    | Miss -> rand1_Move c v
    | _ -> ai_shoot v c x y

  let rec smart1_Move (c : t) (v : BattleGround.t) : bool =
    failwith "unimplemented"
end
