import 'package:flutter/material.dart' show BuildContext, ModalRoute;

/*
  Esta extensión es útil en el contexto de navegación de 
  la interfaz de usuario, donde se pueden pasar argumentos
  a través de las rutas modales
*/
extension GetArgument on BuildContext {
  T? getArgument<T>() {
    final modalRoute = ModalRoute.of(this);
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      if (args != null && args is T) {
        return args as T;
      }
    }
    return null;
  }
}
