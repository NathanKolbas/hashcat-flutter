import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hashcat_flutter/constants.dart';
import 'package:hashcat_flutter/providers/crack_options.dart';
import 'package:provider/provider.dart';

class Target extends StatelessWidget {
  const Target({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 25),
          const Text("Algorithm",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                    value: Provider.of<CrackOptionsProvider>(context).hashType,
                    items: hashType.keys
                        .map((key) => DropdownMenuItem<int>(
                            value: key, child: Text(hashType[key]!)))
                        .toList(),
                    onChanged: (value) {
                      Provider.of<CrackOptionsProvider>(context, listen: false)
                          .setHashType(value);
                    }),
              ),
            ),
          ),
          const SizedBox(height: 50),
          const Text("Enter Target",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const Text("Type or paste a target hash here",
              style: TextStyle(fontSize: 15)),
          const SizedBox(height: 10),
          TextFormField(
            initialValue: Provider.of<CrackOptionsProvider>(context).target,
            onChanged: (value) {
              Provider.of<CrackOptionsProvider>(context, listen: false)
                  .setTarget(value);
            },
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              labelText: "Target Hash",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                print(result.files.single.path);
                Provider.of<CrackOptionsProvider>(context, listen: false)
                    .setTarget(result.files.single.path);
              } else {
                // User canceled the picker
              }
            },
            child: const Text('Import from .txt file'),
          ),
        ],
      ),
    );
  }
}
