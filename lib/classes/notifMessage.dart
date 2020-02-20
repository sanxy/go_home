import 'package:flutter/material.dart';

@immutable
class NotifMessage{
  final String title;
  final String body;

  const NotifMessage({
    @required this.title,
    @required this.body
  });
}