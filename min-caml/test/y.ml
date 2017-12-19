(**** solver のメインルーチン ****)
let rec solver index dirvec org =
  let m = objects.(index) in
  let m_shape = o_form m in
  (* 直線の始点を物体の基準位置に合わせて平行移動 *)
  let b0 =  org.(0) -. o_param_x m in
  let b1 =  org.(1) -. o_param_y m in
  let b2 =  org.(2) -. o_param_z m in
  (* 物体の種類に応じた補助関数を呼ぶ *)
  if m_shape = 1 then       solver_rect m dirvec b0 b1 b2    (* 直方体 *)
  else if m_shape = 2 then  solver_surface m dirvec b0 b1 b2 (* 平面 *)
  else                      solver_second m dirvec b0 b1 b2  (* 2次曲面/円錐 *)
in
test solver
