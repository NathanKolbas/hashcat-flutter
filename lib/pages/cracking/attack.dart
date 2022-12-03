import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hashcat_flutter/constants.dart';
import 'package:hashcat_flutter/providers/crack_options.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

class Attack extends StatelessWidget {
  const Attack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 25),
          const Text(
            "Attack Mode",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: themeDark.hintColor),
                borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  value: Provider.of<CrackOptionsProvider>(context).attackMode,
                  items: attackMode.keys
                      .map((key) => DropdownMenuItem<int>(
                      value: key, child: Text(attackMode[key]!)))
                      .toList(),
                  onChanged: (value) => Provider.of<CrackOptionsProvider>(context, listen: false).attackMode = value,
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          const Text(
            "Dictionary",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                Provider.of<CrackOptionsProvider>(context, listen: false).dictionary = result.files.single.path;
              } else {
                // User canceled the picker
              }
            },
            child: Text(
              Provider.of<CrackOptionsProvider>(context).dictionary.isEmpty ?
              'Import from .dict file' :
              path.basename(Provider.of<CrackOptionsProvider>(context).dictionary),
            ),
          ),
        ],
      ),
    );
  }
}
