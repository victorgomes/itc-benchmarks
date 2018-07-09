let command file id arg =
  Printf.sprintf "cerberus --rewrite --exec --batch %s --args=%03d%03d 2> /dev/null" file id arg

let string_of_input ic =
  let lines = ref [] in
  try
    while true do
      lines := input_line ic :: !lines
    done; ""
  with End_of_file -> String.concat "\n" !lines

let check res =
  let re = Str.regexp_string "Printed from main function" in
  try ignore (Str.search_forward re res 0); true
  with Not_found -> false

let check_unsupported res =
  let re = Str.regexp_string "supported" in
  try ignore (Str.search_forward re res 0); true
  with Not_found -> false

let write_result str =
  let flags = [Open_creat; Open_wronly; Open_append; Open_text] in
  let oc = open_out_gen flags 0o777 "result" in
  output_string oc (str ^ "\n");
  close_out oc

let success file id arg =
  let cmd = command file id arg in
  print_endline ("Running " ^ cmd);
  let outc = Unix.open_process_in cmd in
  let out = string_of_input outc in
  let res = if check out then "OK"
            else if check_unsupported out then "NOT SUPPORTED"
            else "FAIL" in
  write_result ("\t" ^ string_of_int arg ^ ": " ^ res);
  print_endline out;
  ignore(Unix.close_process_in outc)

let failure file id arg =
  let cmd = command file id arg in
  print_endline ("Running " ^ cmd);
  let outc = Unix.open_process_in cmd in
  let out = string_of_input outc in
  let res = if check out then "FAIL" else "OK" in
  write_result ("\t" ^ string_of_int arg ^ ": " ^ res);
  print_endline out;
  ignore(Unix.close_process_in outc)

let run f file (name, id, n) =
  print_endline ("Running " ^ name);
  write_result (name ^ ":");
  let rec loop i = if i <= n then (f file id i; loop (i+1))
  in loop 1

let tests =
  [ ("Bit shift bigger than integral type or negative", 1, 17);
    ("Dynamic buffer overrun",  2, 32);
    ("Dynamic buffer underrun", 3, 39);
    ("Comparison NULL with function pointer", 4, 2);
    ("Contradict conditions", 5, 10);
    ("Integer precision lost because of cast", 6, 19);
    ("Data overflow", 7, 25);
    ("Data underflow", 8, 12);
    ("Dead code", 9, 13);
    (* dead_lock *)
    ("Deletion of data structure sentinel", 11, 3);
    ("Double free", 12, 12);
    (* double_lock *)
    (* double_release *)
    ("Unintentional endless loop", 15, 9);
    ("Free non dynamically allocated memory", 16, 16);
    ("Free NULL pointer", 17, 14);
    ("Bad cast of a function pointer", 18, 15);
    ("Return value of function never checked", 19, 16);
    ("Improper error handling", 20, 4);
    ("Improper termination of block", 21, 4);
    ("Useless assignment", 22, 1);
    (* extern *)
    ("Invalid memory access to already freed area", 24, 17);
    ("Assign small buffer for structure", 25, 11);
    (* live lock *)
    (* locked but never unlock *)
    ("Memory allocation failure", 28, 16);
    ("Memory leakage", 29, 18);
    ("Non void function does not return value", 30, 4);
    ("Dereferencing a NULL pointer", 31, 17);
    ("Static buffer overrun", 32, 54);
    ("Memory copy at overlapping areas", 33, 2);
    (* power (float) *)
    ("Incorrect pointer arithmetic", 35, 2);
    (* race *)
    ("Redundant conditions", 37, 14);
    ("Return of a pointer to a local variable", 38, 2);
    ("Integer sign lost because of unsigned cast", 39, 19);
    (* long lock *)
    (* cross thread stack access *)
    ("Stack overflow", 42, 7);
    ("Stack underrun", 43, 7);
    ("Static buffer underrun", 44, 13);
    ("Uninitialized memory access", 45, 15);
    ("Uninitialized pointer", 46, 16);
    ("Uninitialized variable", 47, 15);
    (* unlock without lock *)
    ("Unused variable", 49, 7);
    ("Wrong arguments passed to a function pointer", 50, 18);
    ("Division by zero", 51, 16);
  ]

let () =
  write_result ("\n\nWithout Defects:\n==========================\n\n");
  let wo_defects = run success "02.wo_Defects.c" in
  ignore (List.map wo_defects tests);
  write_result ("\n\nWith Defects:\n==========================\n\n");
  let w_defects = run failure "01.w_Defects.c" in
  ignore (List.map w_defects tests)


