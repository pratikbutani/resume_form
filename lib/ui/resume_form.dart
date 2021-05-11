import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_form/data/api_handler.dart';
import 'package:resume_form/drop_down_view.dart';
import 'package:resume_form/extensions/widget_extensions.dart';
import 'package:resume_form/models/accounting_exp_model.dart';
import 'package:resume_form/models/exp_request_model.dart';
import 'package:resume_form/models/software_model.dart';
import 'package:resume_form/ui/raw_percentage_view.dart';
import 'package:resume_form/ui/raw_softwere_known_view.dart';
import 'package:resume_form/viewUtility/viewUtil.dart';

import '../constants/constant.dart';
import '../constants/strings.dart';
import '../custom_widget/custom_textview.dart';

class ResumeForm extends StatefulWidget {
  final String title;

  ResumeForm(this.title);

  @override
  _ResumeFormState createState() => _ResumeFormState(title);
}

class _ResumeFormState extends State<ResumeForm> {
  String firstName;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isSubmitted;
  int selectedRadioTile = 0;
  TextEditingController _firstNameController = new TextEditingController();
  TextEditingController _outsourcingExperienceController =
      new TextEditingController();
  TextEditingController _otherProfessionalFieldController =
      new TextEditingController();
  TextEditingController _tf = new TextEditingController();

  TextEditingController _totalExperienceController =
      new TextEditingController();
  TextEditingController _currentCTCController = new TextEditingController();
  TextEditingController _expectedCTCController = new TextEditingController();
  TextEditingController _noticePeriodController = new TextEditingController();
  TextEditingController _preferredLocationController =
      new TextEditingController()..text = 'Ahmedabad';
  String cvPath = '';
  File docFile;
  String uploadedFileName = '';
  static final _formKey = new GlobalKey<FormState>();

  /// just  define _formkey with static final

  // var _formKey = GlobalKey<FormState>();

  String _selectedHighEducation, _selectedProfessionalQualification;

  String title;

  // Group Value for Radio Button.
  int selectedOptionId = 1;
  int selectedDayType = 1;
  List<SoftwareModel> softwareKnownList = List()
    ..addAll(Constants.softwareList);

  List<AccountingExpModel> countryList = List()..addAll(Constants.countryList);

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  _ResumeFormState(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: bg_decoration,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _firstNameController,
                  hintName: Strings.ENTER_FULL_NAME,
                  validation: Strings.FULL_NAME_REQUIRED,
                ),
                SizedBox(height: 15),
                getTitleView(Strings.HEIGHEST_EDUCATION_QUALIFICATION),
                DropDownView(
                  hintText: Constants.STR_SELECT_HIGHEST_EDUCATION_QULIFICATION,
                  items: Constants.ARR_EDUCATION_QULIFICATION,
                  onValueChange: setHeighestQulificationValue,
                  selectedValue: _selectedHighEducation,
                ),
                SizedBox(height: 15),
                Column(
                  children: [
                    getTitleView(Strings.PROFESSIONAL_QUALIFICATION),
                    DropDownView(
                      hintText: Strings.SELECT_PROFESSIONAL_QUALIFICATION,
                      items: Constants.ARR_PROFESSIONAL_QUILIFICATION,
                      onValueChange: (s) {
                        _selectedProfessionalQualification = s;
                        setState(() {});
                      },
                      selectedValue: _selectedProfessionalQualification,
                    ),
                    SizedBox(height: 15),
                    Visibility(
                      visible: _selectedProfessionalQualification == "OTHER",
                      child: CustomTextField(
                        controller: _otherProfessionalFieldController,
                        hintName: Strings.ENTER_PROFESSIONAL_QUALIFICATION,
                        validation: Strings.PROFESSIONAL_QUALIFICATION_REQUIRED,
                      ),
                    ),
                  ],
                ).addBorder(borderRadius: 12, padding: 10),
                SizedBox(height: 15),
                Column(
                  children: [
                    getTitleView(Constants.STR_SOFTWARE_YOU_KNOW),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RawSoftwereKnownView(
                          index: index,
                          onRemoveClick: () {
                            softwareKnownList.removeAt(index);
                            setState(() {});
                          },
                          softwareModel: softwareKnownList[index],
                          onValueChange: (d) {
                            softwareKnownList[index].isEnabled = d;
                            setState(() {});
                          },
                        );
                        /*getPercentageViewRow(
                            softwareKnownList[index], index);*/
                      },
                      itemCount: softwareKnownList.length,
                    ),
                    getButton(Strings.ADD_NEW_SKILL, () {
                      _displayAddSoftwareInputDialog(context, (title) {
                        softwareKnownList.add(SoftwareModel(
                            softwareName: title,
                            isEnabled: false,
                            isCancelable: true));
                        setState(() {});
                      });
                    }),
                  ],
                ).addBorder(borderRadius: 12, padding: 10),
                SizedBox(height: 15),
                CustomTextField(
                  controller: _outsourcingExperienceController,
                  hintName: Strings.OUTSOURCING_EXP_IN_MONTH,
                  validation: Strings.OUTSOURCING_EXP_REQUIRED,
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 15),
                Column(
                        children: [
                  getTitleView(Strings.ACCOUNTING_EXP_IN_WHICH_COUNTRY),
                ]..addAll(countryList.map((e) => RawPercentageView(
                              index: e.index,
                              softwareModel: countryList[e.index],
                              onValueChange: (d) {
                                countryList[e.index].years = d;
                              },
                            ))))
                    .addBorder(borderRadius: 12, padding: 10),
                SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  controller: _totalExperienceController,
                  hintName: Strings.TOTAL_EXP_IN_MONTH,
                  validation: Strings.TOTAL_EXP_REQUIRED,
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: _currentCTCController,
                  hintName: Strings.CURRENT_CTC,
                  validation: Strings.CURRENT_CTC_REQUIRED,
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: _expectedCTCController,
                  hintName: Strings.EXPECTED_SALARY_YEARLY,
                  validation: Strings.EXPECTED_SALARY_REQUIRED,
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: _noticePeriodController,
                  hintName: Strings.NOTICE_PERIOD_IN_MONTH,
                  validation: Strings.NOTICE_PERIOD_REQUIRED,
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: _preferredLocationController,
                  hintName: Strings.PREFERRED_LOCATION,
                  validation: Strings.PREFERRED_LOCATION_REQUIRED,
                  textInputType: TextInputType.name,
                ),
                SizedBox(height: 15),
                getTitleView(Strings.FLEXIBLE_FOR_SHIFT),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    getRadioButton(
                        id: selectedOptionId, typeValue: 1, title: Strings.NO),
                    getRadioButton(
                        id: selectedOptionId, typeValue: 0, title: Strings.YES),
                  ],
                ),
                Visibility(
                  visible: selectedOptionId == 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      getRadioButton(
                          id: selectedDayType,
                          typeValue: 1,
                          title: Strings.MORNING,
                          isMainTitle: false),
                      getRadioButton(
                          id: selectedDayType,
                          typeValue: 2,
                          title: Strings.NIGHT,
                          isMainTitle: false),
                      getRadioButton(
                          id: selectedDayType,
                          typeValue: 3,
                          title: Strings.DAY,
                          isMainTitle: false),
                    ],
                  ),
                ),
                getButton(
                    uploadedFileName != ''
                        ? uploadedFileName
                        : Strings.DROP_CV_HERE, () {
                  getPdfAndUpload();
                }),
                getButton(Strings.SUBMIT, () {
                  if (_formKey.currentState.validate()) {
                    if (isNull(_selectedHighEducation)) {
                      showInSnackBar(Strings.PLEASE_SELECT_HEIGHEST_EDUCATION);
                      return;
                    } else if (isNull(_selectedProfessionalQualification)) {
                      showInSnackBar(
                          Strings.PLESE_SELECT_PROFESSIONAL_QUALIFICATION);
                    } else if (isNull(getSoftwareKnown())) {
                      showInSnackBar('Please Select Any Software From List');
                    } else if (isNull(cvPath)) {
                      showInSnackBar(Strings.PLESE_SELECT_UPLOAD_CV);
                    } else {
                      String name = _firstNameController.text;
                      String highestEducation = _selectedHighEducation;
                      String professionalQualification =
                          _selectedProfessionalQualification;
                      String outSourcingExp =
                          _outsourcingExperienceController.text;
                      String totalExp = _totalExperienceController.text;
                      String currentCtc = _currentCTCController.text;
                      String expectedSalary = _expectedCTCController.text;
                      String noticePeriod = _noticePeriodController.text;
                      String prefferdLocation =
                          _preferredLocationController.text;
                      print(
                          "FlexibleShift Selected ${selectedOptionId == 1 ? "Yes" : "NO"}");
                      print("cvPath $cvPath");
                      ViewUtil.showLoaderDialog(context);

                      ApiHandler().uploadFile(
                          body: getData(),
                          filePath: cvPath,
                          onComplate: () {
                            Navigator.pop(context);
                          },
                          onSucess: (msg) {
                            showInSnackBar(msg);
                          });

                    }
                  }
                })
              ],
            ),
          ).paddingAll(24),
        ),
      ),
    );
  }

  String getSelectedDayType(int type) {
    if (type == 1) {
      return Strings.MORNING;
    } else if (type == 2) {
      return Strings.NIGHT;
    } else {
      return Strings.DAY;
    }
  }

  Widget getTitleView(String text) {
    return Align(
        alignment: Alignment.centerLeft, child: Text(text).paddingAll(8));
  }

  Future getPdfAndUpload() async {
    var rng = new Random();
    String randomName = "";
    for (var i = 0; i < 20; i++) {
      print(rng.nextInt(100));
      randomName += rng.nextInt(100).toString();
    }
    FilePickerResult file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (file != null) {
      print("originfilename ${file.files.first.name}");
      uploadedFileName = file.files.first.name;
      String fileName = '${randomName}.pdf';
      print(fileName);
      cvPath = file.paths.first;
      print(file.paths.first);
      setState(() {});
    }
  }

  Widget getRadioButton(
      {int typeValue, int id, String title, bool isMainTitle = true}) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isMainTitle) {
            this.selectedOptionId = typeValue;
          } else {
            this.selectedDayType = typeValue;
          }
        });
      },
      child: Row(
        children: [
          Radio(
            activeColor: Colors.red,
            value: typeValue,
            groupValue:
                isMainTitle ? this.selectedOptionId : this.selectedDayType,
          ),
          Text(
            title,
            style: new TextStyle(fontSize: 17.0),
          ),
        ],
      ),
    );
  }

  int value;

  void setHeighestQulificationValue(String s) {
    setState(() {
      _selectedHighEducation = s;
    });
  }

  void _displayAddSoftwareInputDialog(
      BuildContext context, Function(String) onCallback) async {
    TextEditingController textEditingController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(Strings.ADD_SKILL),
            content: TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: Strings.SKILL_NAME),
            ),
            actions: <Widget>[
              getFlatButton(Strings.CANCEL, () {
                Navigator.pop(context);
              }),
              getFlatButton(Strings.ADD, () {
                if (textEditingController.text != '') {
                  onCallback(textEditingController.text);
                }
                Navigator.pop(context);
              }),
            ],
          );
        });
  }

  Widget getFlatButton(String title, VoidCallback onClick) {
    return FlatButton(
      color: Colors.green,
      textColor: Colors.white,
      child: Text(title),
      onPressed: () {
        onClick();
      },
    );
  }

  BoxDecoration get bg_decoration => BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.orange.withOpacity(0.5),
              Colors.orangeAccent.withOpacity(0.5),
              Colors.red.withOpacity(0.5),
              Colors.redAccent.withOpacity(0.5)
            ],
            begin: Alignment.topLeft, //begin of the gradient color
            end: Alignment.bottomRight, //end of the gradient color
            stops: [0, 0.2, 0.5, 0.8] //stops for individual color
            ),
      );

  getButton(String title, VoidCallback onClick) {
    return RaisedButton(
      color: Colors.blueAccent,
      padding: EdgeInsets.all(10),
      onPressed: () {
        onClick();
      },
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ).setFullWidth();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  bool isNull(String s) {
    if (s == null || s == '') {
      return true;
    }
    return false;
  }

  String getSoftwareKnown() {
    String softwareknown = '';
    for (int i = 0; i < softwareKnownList.length; i++) {
      if (softwareKnownList[i].isEnabled) {
        if (softwareknown == '') {
          softwareknown = softwareKnownList[i].softwareName;
        } else {
          softwareknown =
              softwareknown + "," + softwareKnownList[i].softwareName;
        }
      }
    }
    return softwareknown;
  }

  String getAccountingExp() {
    List<ExpRequestModel> expList = List();
    for (int i = 0; i < countryList.length; i++) {
      expList.add(ExpRequestModel(
          countryId: countryList[i].index + 1, exp: countryList[i].years));
    }
    return jsonEncode(expList);
  }

  Map<String, dynamic> getData() {
    return {
      'fullName': _firstNameController.text.trim(),
      'heighestEducationQualification': _selectedHighEducation,
      'professionalQualification': _selectedProfessionalQualification == "OTHER"
          ? _otherProfessionalFieldController.text.trim()
          : _selectedProfessionalQualification,
      'softwareKnown': getSoftwareKnown(),
      'outsourcingExp': _outsourcingExperienceController.text.trim(),
      'accountExpCountryWise': getAccountingExp(),
      'totalExp': _totalExperienceController.text.trim(),
      'currentSalary': _currentCTCController.text.trim(),
      'expectedSalary': _expectedCTCController.text.trim(),
      'noticePeriod': _noticePeriodController.text.trim(),
      'prefferedLocation': _preferredLocationController.text.trim(),
      'flexibleForShift': selectedOptionId.toString(),
      'selectedShift':
          selectedOptionId == 0 ? getSelectedDayType(selectedDayType) : ''
    };
  }
}
