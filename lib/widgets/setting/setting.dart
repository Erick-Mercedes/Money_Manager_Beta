import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/widgets/setting/constants.dart';

class Setting {
  final String title;
  final String route;
  final IconData icon;
  final Color color;

  Setting({
    required this.title,
    required this.route,
    required this.icon,
    required this.color,
  });
}

final List<Setting> settings = [
  Setting(
    title: "Perfil",
    route: "/datos-personales",
    icon: CupertinoIcons.person_fill,
    color: PersonColor,
  ),
  Setting(
    title: "Configuración",
    route: "/configuracion",
    icon: Icons.settings,
    color: SettingColor,
  ),
  /*Setting(
    title: "Cursos financieros",
    route: "/avatar",
    icon: CupertinoIcons.videocam_fill,
    color: CursoColor,
  ),*/
];

final List<Setting> settings2 = [
  /*Setting(
    title: "Divisas",
    route: "/divisas",
    icon: Icons.calculate_outlined,
    color: ComunidadColor,
  ),*/
  Setting(
    title: "Invitar amigos",
    route: "/referencia",
    icon: CupertinoIcons.heart_fill,
    color: CodeColor,
  ),
  Setting(
    title: "Preguntas frecuentes",
    route: "/preguntas",
    icon: CupertinoIcons.ellipsis_vertical_circle_fill,
    color: PreguntaColor,
  ),
  Setting(
    title: "Acerca de",
    route: "/acerca-de",
    icon: CupertinoIcons.pencil_circle_fill,
    color: AcercaColor,
  ),
];
/**===================PARTE DE LA CONFIGURACION============================== */
/*--NOTIFICACION Y APRIENCIA --*/
final List<Setting> settings3 = [
  /*Setting(
    title: "Notificaciones",
    route: "/notificaciones",
    icon: Icons.circle_notifications_outlined,
    color: configColor,
  ),*/
  Setting(
    title: "Apariencia",
    route: "/temas",
    icon: Icons.brush_outlined,
    color: configColor,
  ),
];
/* -- SEGURIDAD -- */
final List<Setting> settings4 = [
  Setting(
    title: "Permisos y seguridad",
    route: "/permisos",
    icon: Icons.lock_outline,
    color: configColor,
  ),
  Setting(
    title: "Politica y Privacidad",
    route: "/privacidad",
    icon: Icons.security_outlined,
    color: configColor,
  ),
];

/* -- SITIOS -- */
final List<Setting> settings5 = [
  /*Setting(
    title: "Comunidad",
    route: "/comunidad",
    icon: Icons.groups_2_outlined,
    color: configColor,
  ),*/
  Setting(
    title: "Calificanos",
    route: "/calificar",
    icon: Icons.star_border_rounded,
    color: configColor,
  ),
  /*Setting(
    title: "Blog Money",
    route: "/blog",
    icon: Icons.laptop_windows_outlined,
    color: configColor,
  ),*/
  Setting(
    title: "Contactanos",
    route: "/contacto",
    icon: Icons.mark_email_read_outlined,
    color: configColor,
  ),
];
