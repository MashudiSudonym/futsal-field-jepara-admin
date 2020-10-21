import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FieldInformationMenu {
  final int id;
  final String name;
  final icon;
  final Color color;

  FieldInformationMenu({
    this.id,
    this.name,
    this.icon,
    this.color,
  });
}

// data menu
List<FieldInformationMenu> fieldInformationMenu = [
  FieldInformationMenu(
    id: 1,
    name: 'Daftar Lapangan',
    icon: FontAwesomeIcons.receipt,
  ),
  FieldInformationMenu(
    id: 2,
    name: 'Jadwal Lapangan',
    icon: FontAwesomeIcons.bullhorn,
  ),
];
