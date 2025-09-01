import ffi/mnesia
import gleam/io
import gleam/string

pub fn main() {
  io.println("Starting...")

  let _init_result = mnesia.init()
  io.println("Init done")

  let add_result = mnesia.add_user(1, "Juan")
  io.println("Add done")

  let get_result = mnesia.get_user(1)
  io.println("Get done")

  // Usa string.inspect en lugar de concatenación directa
  io.println("Add result:")
  io.println(string.inspect(add_result))

  io.println("Get result:")
  io.println(string.inspect(get_result))
}
