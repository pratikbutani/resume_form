import 'package:flutter/material.dart';

import 'design.dart';

class ResumeForm extends StatefulWidget {
  final String title;

  ResumeForm(this.title);

  @override
  _ResumeFormState createState() => _ResumeFormState(title);
}

class _ResumeFormState extends State<ResumeForm> {
  String firstName;

  bool isSubmitted;

  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _outsourcingExperienceController =
      new TextEditingController();
  TextEditingController _accExpCountryController = new TextEditingController();
  TextEditingController _totalExperienceController =
      new TextEditingController();
  TextEditingController _currentCTCController = new TextEditingController();
  TextEditingController _expectedCTCController = new TextEditingController();
  TextEditingController _noticePeriodController = new TextEditingController();
  TextEditingController _preferredLocationController =
      new TextEditingController();
  TextEditingController _flexibleForShiftController =
      new TextEditingController();
  TextEditingController _dropCVController = new TextEditingController();

  var _formKey = GlobalKey<FormState>();

  String _selectedHighEducation, _selectedProfessionalQualification;

  String title;

  _ResumeFormState(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _firstNameTextInputField(),
                SizedBox(height: 15),
                _highestEducationTextInputField(),
                SizedBox(height: 15),
                _professionalQualificationTextInputField(),
                SizedBox(height: 15),
                //_softwareKnownTextInputField(),
                SizedBox(height: 15),
                _firstNameTextInputField(),
                SizedBox(height: 15),
                _firstNameTextInputField(),
                SizedBox(height: 15),
                _firstNameTextInputField(),
                SizedBox(height: 15),
                _firstNameTextInputField(),
                SizedBox(height: 15),
                _firstNameTextInputField(),
                SizedBox(height: 15),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _firstNameTextInputField() {
    return TextFormField(
      controller: _firstNameController,
      decoration: getInputDecoration("Enter Full Name"),
      keyboardType: TextInputType.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) {
        if (val.length == 0) return "Full Name Required";
        return null;
      },
    );
  }

  _highestEducationTextInputField() {
    return Container(
      height: 5 ,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<String>(
        icon: Icon(Icons.school_outlined),
        value: _selectedHighEducation,
        underline: SizedBox(),
        isExpanded: true,
        focusColor: Theme.of(context).primaryColor,
        iconEnabledColor: Theme.of(context).primaryColor,
        iconDisabledColor: Colors.grey,
        iconSize: 32,
        items: <String>['Graduate', 'Post Graduate', 'Doctorate']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        hint: Text("Select Education"),
        onChanged: (newValue) {
          setState(() {
            _selectedHighEducation = newValue;
          });
        },
      ),
    );
  }

  _professionalQualificationTextInputField() {
    return Container(
      height: 58,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButton<String>(
        icon: Icon(Icons.corporate_fare_outlined),
        value: _selectedProfessionalQualification,
        underline: SizedBox(),
        isExpanded: true,
        focusColor: Theme.of(context).primaryColor,
        iconEnabledColor: Theme.of(context).primaryColor,
        iconDisabledColor: Colors.grey,
        iconSize: 32,
        items: <String>['CA', 'CPA', 'CS', 'CMA', 'Other']
            .map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        hint: Text("Select Professional Qualification"),
        onChanged: (newValue) {
          setState(() {
            _selectedProfessionalQualification = newValue;
          });
        },
      ),
    );
  }

  _buttonSubmit() {
    return RaisedButton(
      onPressed: () {
        if (_formKey.currentState.validate())
          print("Text ${_firstNameController.text}");
      },
      child: Text("Submit"),
    );
  }
}
