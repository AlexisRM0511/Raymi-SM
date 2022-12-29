class Constants {
  // Texts
  static const String appName = 'Raymi SM';
  static const String appVersion = '1.0.0';
  static const String registerEvent = 'Registrar evento';
  static const String updateEvent = 'Actualizar evento';
  static const String registerUser = 'Registrar usuario';
  static const String updateUser = 'Actualizar usuario';
  static const String eventsForUser = 'Eventos creados por el usuario';
  static const String recordNotFound = 'No se encontraron registros';

  // Paths
  static const String pathLogoWhite = 'assets/icon/logo_white.png';
  static const String pathLogoRed = 'assets/icon/logo_red.png';

  // Regex
  static const String reggexEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  // Collections
  static const String collectionUsers = "Users";
  static const String collectionEvents = "Events";

  // Errors Register
  static const String passwordWeak = 'La contraseña es muy débil.';
  static const String emailInUse = 'El correo electrónico ya está en uso.';
  static const String invalidEmail = 'El correo electrónico no es válido.';

  // Errors Login
  static const String invalidPassword = 'La contraseña no es validate.';
  static const String userNotFound = 'Usuario no encontrado.';
  static const String userDisabled = 'Usuario deshabilitado.';
  static const String wrongPassword = 'Contraseña incorrecta.';
  static const String tooManyRequests = 'Demasiadas solicitudes.';
  static const String errorLogin = 'Error al iniciar sesión.';
  static const String credentialsInvalid = 'Credenciales inválidas.';

  // Constants User Service
  static const String userCreated = 'Usuario creado.';
  static const String errorCreatingUser = 'Error al crear el usuario.';
  static const String userGetted = 'Usuario obtenido.';
  static const String errorGettingUser = 'Error al obtener el usuario.';
  static const String userUpdated = 'Usuario actualizado.';
  static const String errorUpdatingUser = 'Error al actualizar el usuario.';
  static const String userDeleted = 'Usuario eliminado.';
  static const String errorDeletingUser = 'Error al eliminar el usuario.';
  static const String usersGetted = 'Usuarios obtenidos.';
  static const String errorGettingUsers = 'Error al obtener los usuarios.';

//  Constants Event Service
  static const String eventCreated = 'Evento creado.';
  static const String errorCreatingEvent = 'Error al crear el evento.';
  static const String eventGetted = 'Evento obtenido.';
  static const String errorGettingEvent = 'Error al obtener el evento.';
  static const String eventUpdated = 'Evento actualizado.';
  static const String errorUpdatingEvent = 'Error al actualizar el evento.';
  static const String eventDeleted = 'Evento eliminado.';
  static const String errorDeletingEvent = 'Error al eliminar el evento.';
  static const String eventsGetted = 'Eventos obtenidos.';
  static const String errorGettingEvents = 'Error al obtener los eventos.';
}
