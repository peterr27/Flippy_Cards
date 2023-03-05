import 'package:flutter/material.dart';

extension WhiteSpace on num {
  SizedBox get sh => SizedBox(width: toDouble());

  SizedBox get sv => SizedBox(height: toDouble());
}
