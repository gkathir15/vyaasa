import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget BackButton(TargetPlatform targetPlatform) {
  if (TargetPlatform.android == targetPlatform)
    return new Icon(Icons.arrow_back);
  else
    new Icon(CupertinoIcons.back);
}
