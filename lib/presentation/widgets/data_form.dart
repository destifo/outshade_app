import 'package:flutter/material.dart';
import 'package:outshade_app/data/shared_prefs/SharedPrefService.dart';

class DataForm extends StatefulWidget {
  final name;
  const DataForm({required this.name, super.key});

  @override
  State<DataForm> createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  String? selectedGender = 'Male';
  final List<String> genders = ['Male', 'Female'];
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      title: const Text('Sign in'),
      content: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          // height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: ageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text('Age'),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: DropdownButton<String>(
                  iconDisabledColor: Colors.white,
                  value: selectedGender,
                  items: genders
                      .map(
                        (gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    SharedPrefService prefService = SharedPrefService();
                    prefService.setName(widget.name);
                    prefService.setAge(double.parse(ageController.text));
                    prefService.setGender(selectedGender!);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
