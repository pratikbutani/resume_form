import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// add Padding Property to widget
extension WidgetExtension on Widget {
  /// With custom width
  Container addBorder({double borderRadius: 0, double padding: 0}) => Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(
                borderRadius) //                 <--- border radius here
            ),
      ),
      child: this);

  SizedBox setFullWidth() => SizedBox(width: double.maxFinite, child: this);

  /// return padding all
  Padding paddingAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }
}


