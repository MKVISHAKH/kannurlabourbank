import 'package:flutter/material.dart';

class Event {
  final String? title;
  final String? description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final int? todolistId;
  final bool isAllday;
  Event({
    required this.title,
    this.description,
    required this.from,
    required this.to,
    this.backgroundColor = const Color.fromARGB(255, 150, 3, 3),
    this.todolistId,
    this.isAllday = false,
  });
  Event.val({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    required this.todolistId,
    this.backgroundColor = const Color.fromARGB(255, 150, 3, 3),
    this.isAllday = false,
  });
}
