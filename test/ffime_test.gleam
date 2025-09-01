import ffi/mnesia
import gleam/string
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
  // The result is a Charlist, so inspect shows the constructor
  should.equal(string.inspect(result), "charlist.from_string(\"ok\")")
}

pub fn get_user_test() {
  let _ = mnesia.init_test()
  // Usa init_test
  let _ = mnesia.add_user(2, "AnotherUser")
  let result = mnesia.get_user(2)
  should.equal(
    string.inspect(result),
    "charlist.from_string(\"found: AnotherUser\")",
  )
}
