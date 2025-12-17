import 'package:flutter/material.dart';

class StatItemModel {
  final String number;
  final String label;

  StatItemModel({required this.number, required this.label});
}

class FeatureItemModel {
  final IconData icon;
  final String title;
  final String description;

  FeatureItemModel({required this.icon, required this.title, required this.description});
}