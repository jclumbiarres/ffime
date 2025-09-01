@external(erlang, "database", "init")
pub fn init() -> String

@external(erlang, "database", "init_test")
pub fn init_test() -> String

@external(erlang, "database", "add_user")
pub fn add_user(id: Int, name: String) -> String

@external(erlang, "database", "get_user")
pub fn get_user(id: Int) -> String
