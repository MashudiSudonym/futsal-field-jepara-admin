import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeMenu {
  final String name;
  final icon;

  HomeMenu({
    this.name,
    this.icon,
  });
}

// data menu
List<HomeMenu> homeMenu = [
  HomeMenu(
    name: "Informasi Lapangan",
    icon: FontAwesomeIcons.bullhorn,
  ),
  HomeMenu(name: "Pesanan Masuk", icon: FontAwesomeIcons.receipt),
  HomeMenu(
    name: "Informasi Lapangan",
    icon: FontAwesomeIcons.infoCircle,
  ),
  HomeMenu(
    name: "Daftar Pesan Lapangan",
    icon: FontAwesomeIcons.solidStickyNote,
  ),
  HomeMenu(
    name: "Profil Admin",
    icon: FontAwesomeIcons.userSecret,
  ),
  HomeMenu(
    name: "Keluar Akun",
    icon: FontAwesomeIcons.powerOff,
  ),
];
