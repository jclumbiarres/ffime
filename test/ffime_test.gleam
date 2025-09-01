import ffi/mnesia
import gleam/erlang/charlist
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn init_test() {
  let result = mnesia.init_test()
  // Usa string.inspect para convertir charlist a string
  should.equal(result, "init_ok")
}

pub fn add_user_test() {
  let _ = mnesia.init_test()
  let result = mnesia.add_user(1, "TestUser")
  let result_to_string = charlist.from_string(result)
  let result_ok_to_charlist = charlist.from_string("ok")
  should.equal(result_to_string, result_ok_to_charlist)
}

pub fn get_user_test() {
  let _ = mnesia.init_test()
  // Usa init_test
  let _ = mnesia.add_user(2, "AnotherUser")
  let result = mnesia.get_user(2)
  let result_to_string = charlist.from_string(result)
  let result_found_to_charlist = charlist.from_string("found: AnotherUser")
  should.equal(result_to_string, result_found_to_charlist)
}
