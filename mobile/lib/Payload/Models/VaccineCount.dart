import 'package:flutter/material.dart';

class VaccineCount {
  final int id;
  final int count;
  final String vaccine;
  final Color color;

  const VaccineCount({
    required this.id,
    required this.count,
    required this.vaccine,
    required this.color
  });
}