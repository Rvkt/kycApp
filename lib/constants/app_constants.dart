import 'package:flutter/material.dart';

class Device {
  BuildContext context;

  Device(this.context);

  double get width => MediaQuery.of(context).size.width;

  double get height => MediaQuery.of(context).size.height;
}