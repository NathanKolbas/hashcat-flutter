import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hashcat_flutter/constants.dart';
import 'package:hashcat_flutter/providers/crack_options.dart';
import 'package:provider/provider.dart';

class Attack extends StatelessWidget {
  const Attack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Attack Mode",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          DropdownButton(
              value: Provider.of<CrackOptionsProvider>(context).attackMode,
              items: attackMode.keys
                  .map((key) => DropdownMenuItem<int>(
                      value: key, child: Text(attackMode[key]!)))
                  .toList(),
              onChanged: (value) {
                Provider.of<CrackOptionsProvider>(context, listen: false)
                    .setAttackMode(value);
              }),
          const SizedBox(height: 50),
          const Text("Dictionary",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),

          TextButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                print(result.files.single.path);
                Provider.of<CrackOptionsProvider>(context, listen: false)
                    .setDictionary(result.files.single.path);
              } else {
                // User canceled the picker
              }
            },
            child: const Text('Import from .dict file'), //TODO we could change the text to be the filename after import finishes
          ),
          const SizedBox(height: 50),
          const Text("Potentially more options will be needed here based on attack mode",
              style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
