@external(erlang, "database", "init")
pub fn init() -> String

// Cambia a String también

@external(erlang, "database", "add_user")
pub fn add_user(id: Int, name: String) -> String

// Cambia a String

@external(erlang, "database", "get_user")
pub fn get_user(id: Int) -> String
