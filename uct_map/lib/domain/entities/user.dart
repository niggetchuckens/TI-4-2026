import 'user_role.dart';

// Entidad de dominio: espejo móvil de Identidad_Usuario (sin contraseña).
class User {
  final String id;
  final String nombre;
  final String correo;
  final String idRol;
  final UserRole rol;
  final DateTime? fechaRegistro;

  const User({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.idRol,
    required this.rol,
    this.fechaRegistro,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final rolRaw =
        json['rol'] ?? json['rolNombre'] ?? json['rol_nombre'] ?? 'desconocido';
    final fechaRaw =
        json['fechaRegistro'] ?? json['fecha_registro'] ?? json['createdAt'];
    return User(
      id: _str(json['id'] ?? json['id_usuario'] ?? json['idUsuario']),
      nombre: _str(json['nombre']),
      correo: _str(json['correo'] ?? json['email']),
      idRol: _str(json['idRol'] ?? json['id_rol']),
      rol: UserRole.fromString(rolRaw),
      fechaRegistro:
          fechaRaw is String ? DateTime.tryParse(fechaRaw) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id_usuario': id,
        'nombre': nombre,
        'correo': correo,
        'id_rol': idRol,
        'rol': rol.toShortString(),
        if (fechaRegistro != null)
          'fecha_registro': fechaRegistro!.toIso8601String(),
      };

  User copyWith({
    String? id,
    String? nombre,
    String? correo,
    String? idRol,
    UserRole? rol,
    DateTime? fechaRegistro,
  }) {
    return User(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      correo: correo ?? this.correo,
      idRol: idRol ?? this.idRol,
      rol: rol ?? this.rol,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          id == other.id &&
          nombre == other.nombre &&
          correo == other.correo &&
          idRol == other.idRol &&
          rol == other.rol;

  @override
  int get hashCode => Object.hash(id, nombre, correo, idRol, rol);
}

String _str(dynamic v) => v?.toString() ?? '';
