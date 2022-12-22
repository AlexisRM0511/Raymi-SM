class Constants {
  // Texts
  static const String appName = 'Raymi SM';

  // Paths
  static const String pathLogo = 'assets/icon/logo.png';

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
  static const String errorCreatingUser = 'Error al crear el usuario.';

  // Errors Login
  static const String invalidPassword = 'La contraseña no es validate.';
  static const String userNotFound = 'Usuario no encontrado.';
  static const String userDisabled = 'Usuario deshabilitado.';
  static const String wrongPassword = 'Contraseña incorrecta.';
  static const String tooManyRequests = 'Demasiadas solicitudes.';
  static const String errorLogin = 'Error al iniciar sesión.';
  static const String credentialsInvalid = 'Credenciales inválidas.';

}
