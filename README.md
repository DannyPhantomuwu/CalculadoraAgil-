# Calculadora Ágil

Aplicación de calculadora para una evidencia de Scrum. Está desarrollada con Flutter para poder trabajar con una misma base de código en Android e iOS.

## Funciones

Operaciones básicas, potencias, paréntesis, decimales y números negativos; visualización separada de la operación y el resultado; AC, retroceso y mensajes de error. Los resultados se muestran con hasta cinco decimales.

## Ejecución

Instalar Flutter SDK y Android Studio, y abrir una terminal en la carpeta del proyecto:

```bash
flutter create --platforms=android,ios .
flutter pub get
flutter run
```

Pruebas unitarias: `flutter test`.

**Estado:** código fuente preparado; todavía falta ejecutarlo en un emulador y guardar la evidencia de las pruebas. La compatibilidad con iOS deberá verificarse desde macOS.

## Organización del trabajo

Las tareas se manejan en un backlog y se hacen cambios por rama mediante Pull Requests. El proyecto se está realizando de manera individual, por lo que el requisito de revisión por otro compañero queda pendiente de autorización del profesor.
