import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:resume_form/constants/strings.dart';

class ApiHandler {
  void uploadFile(
      {Map<String, dynamic> body,
      String filePath,
      Function(String) onSucess,
      VoidCallback onComplate}) async {
    var uri = Uri.parse(Strings.API);

    var request = new MultipartRequest("POST", uri);
    request.headers.addAll({
      "user-key":
          "VW8tmt6cglGvzMf7kJDFXichs3O3y6jrs2HIuDu0anubHaAcDzig0hizp3U2RR24XGRI14yIlq4S9iaOdI0C7q64djHyivWL57nbhYGu4QwFwfDzIrwGAxac",
    });
/*
    request.fields["fullName"] = fullName;
    request.fields["heighestEducationQualification"] = heighestEducation;

    request.fields["professionalQualification"] =
    _selectedProfessionalQualification == "OTHER"
        ? _otherProfessionalFieldController.text.trim()
        : _selectedProfessionalQualification;
    request.fields["softwareKnown"] = getSoftwareKnown();
    request.fields["outsourcingExp"] =
        _outsourcingExperienceController.text.trim();
    request.fields["accountExpCountryWise"] = getAccountingExp();
    request.fields["totalExp"] = _totalExperienceController.text.trim();
    request.fields["currentSalary"] = _currentCTCController.text.trim();
    request.fields["expectedSalary"] = _expectedCTCController.text.trim();
    request.fields["noticePeriod"] = _noticePeriodController.text.trim();
    request.fields["prefferedLocation"] =
        _preferredLocationController.text.trim();
    request.fields["flexibleForShift"] = selectedOptionId.toString();
    request.fields["selectedShift"] =
    selectedOptionId == 0 ? getSelectedDayType(selectedDayType) : '';
*/
    body.entries.forEach((element) {
      request.fields[element.key] = element.value;
    });
    print(request.fields.entries);
    final File file = File(filePath);
    MultipartFile multipartFilen = await MultipartFile(
        'file',
        ByteStream(DelegatingStream.typed(file.openRead())),
        await file.length(),
        filename: file.path.split('/').last);

    request.files.add(multipartFilen);

    // send request to upload file
    await request.send().then((response) async {
      response.stream.transform(utf8.decoder).listen((value) {
        print("checkoutpots");

        print(value);
        var jsonResponse = json.decode(value);
        onSucess(jsonResponse['message']);
        //        showInSnackBar(jsonResponse['message']);
      });
    }).catchError((e) {
      print(e);
    }).whenComplete(() {
      onComplate();
      //      Navigator.pop(context);
    });
  }
}
