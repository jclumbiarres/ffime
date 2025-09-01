import ffi/mnesia
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn init_test() {
  let result = mnesia.init()
  should.equal(result, "ok")
}

pub fn add_user_test() {
  let _ = mnesia.init()
  let result = mnesia.add_user(1, "TestUser")
  should.equal(result, "ok")
}

pub fn get_user_test() {
  let _ = mnesia.init()
  let _ = mnesia.add_user(2, "AnotherUser")
  let result = mnesia.get_user(2)
  should.equal(result, "found: AnotherUser")
}

pub fn get_nonexistent_user_test() {
  let _ = mnesia.init()
  let result = mnesia.get_user(999)
  should.equal(result, "not_found")
}
