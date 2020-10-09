import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeMenu {
  final int id;
  final String name;
  final icon;
  final Color color;

  HomeMenu({
    this.id,
    this.name,
    this.icon,
    this.color,
  });
}

// data menu
List<HomeMenu> homeMenu = [
  HomeMenu(
    id: 1,
    name: 'Informasi Lapangan',
    icon: FontAwesomeIcons.bullhorn,
    color: Colors.orange[600],
  ),
  HomeMenu(
    id: 2,
    name: 'Pesanan Masuk',
    icon: FontAwesomeIcons.receipt,
    color: Colors.blue[600],
  ),
  HomeMenu(
    id: 3,
    name: 'Profil Admin',
    icon: FontAwesomeIcons.userSecret,
    color: Colors.indigoAccent,
  ),
  HomeMenu(
    id: 4,
    name: 'Keluar Akun',
    icon: FontAwesomeIcons.powerOff,
    color: Colors.red,
  ),
];
