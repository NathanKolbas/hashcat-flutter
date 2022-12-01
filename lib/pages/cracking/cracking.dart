import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hashcat_flutter/constants.dart';
import 'package:hashcat_flutter/providers/crack_options.dart';
import 'package:provider/provider.dart';

class Cracking extends StatelessWidget {
  const Cracking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text("Starting point should now be target.dart",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
