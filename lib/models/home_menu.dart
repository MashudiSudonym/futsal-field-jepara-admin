import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeMenu {
  final String name;
  final FaIcon icon;

  HomeMenu({
    this.name,
    this.icon,
  });
}

// data menu
List<HomeMenu> homeMenu = [
  HomeMenu(
    name: "Informasi Lapangan",
    icon: FaIcon(FontAwesomeIcons.infoCircle),
  ),
  HomeMenu(
    name: "Daftar Pesan Lapangan",
    icon: FaIcon(FontAwesomeIcons.solidStickyNote),
  ),
  HomeMenu(
    name: "Informasi Lapangan",
    icon: FaIcon(FontAwesomeIcons.infoCircle),
  ),
  HomeMenu(
    name: "Daftar Pesan Lapangan",
    icon: FaIcon(FontAwesomeIcons.solidStickyNote),
  ),
];
