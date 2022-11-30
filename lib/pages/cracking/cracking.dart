import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Cracking extends StatelessWidget {
  const Cracking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                print(result.files.single.path);
              } else {
                // User canceled the picker
              }
            },
            child: const Text('Open File'),
          ),
        ],
      ),
    );
  }
}
