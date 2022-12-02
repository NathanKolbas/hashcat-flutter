import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hashcat_flutter/constants.dart';
import 'package:hashcat_flutter/providers/crack_options.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';

class Output extends StatelessWidget {
  const Output({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 25),
          const Text("Output Format",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          DropDownMultiSelect(
            hint: const Text("Select output format(s)"),
            onChanged: (List<String> value) {
              Provider.of<CrackOptionsProvider>(context, listen: false)
                  .setOutfileFormat(value);
            },
            options: outputFormat.keys.toList(),
            selectedValues:
                Provider.of<CrackOptionsProvider>(context).outfileFormat,
            whenEmpty: "Select output format(s)",
            menuItembuilder: (value) {
              return Text(outputFormat[value]!);
            },
            childBuilder: (values) {
              return Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(values.map((value) => outputFormat[value]!).join(", "))
              );
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 50),
          const Text("Extra Arguments",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextFormField(
            initialValue: Provider.of<CrackOptionsProvider>(context).extraArgs,
            onChanged: (value) {
              Provider.of<CrackOptionsProvider>(context, listen: false)
                  .setExtraArgs(value);
            },
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              labelText: "--args",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
