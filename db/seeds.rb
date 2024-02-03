UserType.create(id: 1, name_type: "Administrador")
UserType.create(id: 2, name_type: "Normal")
User.create(username: "admin", password: "admin123", user_type_id: UserType.first.id)
User.create(username: "user", password: "112233", user_type_id: UserType.last.id)