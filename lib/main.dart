import 'package:flutter/material.dart';
import 'package:starter_template/injection.dart';
import 'package:starter_template/presentation/core/app_widget.dart';

void main() {
  configureDependencies();
  runApp(AppWidget());
}
