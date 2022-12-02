import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hashcat_flutter/components/progress_stepper.dart';

class Cracking extends StatelessWidget {
  const Cracking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProgressStepper(
      steps: const [
        ProgressStepperStep(
          icon: Icon(Icons.adjust),
          label: 'Target',
        ),
        ProgressStepperStep(
          icon: Icon(Icons.construction),
          label: 'Attack',
        ),
        ProgressStepperStep(
          icon: Icon(Icons.assignment_turned_in),
          label: 'Finalize',
        ),
      ],
      pages: [
        Center(
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
        ),
        Center(),
        Center(),
      ],
    );
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
