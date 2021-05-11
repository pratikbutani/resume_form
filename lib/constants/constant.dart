import 'package:resume_form/models/accounting_exp_model.dart';
import 'package:resume_form/models/software_model.dart';

class Constants {
  static final List<String> ARR_EDUCATION_QULIFICATION = [
    "Graduate",
    "Post Graduate",
    "Doctorate"
  ];

  static final List<String> ARR_PROFESSIONAL_QUILIFICATION = [
    "CA",
    "CPA",
    "CS",
    "CMA",
    "OTHER",
  ];

  static final List<String> ARR_SOFTWARE_YOU_KNOW = [
    "Xero",
    "QuickBook",
    "SAGE",
    "Other",
  ];

  static List<AccountingExpModel> countryList = [
    AccountingExpModel(softwareName: 'US', years: 0, index: 0),
    AccountingExpModel(softwareName: 'UK', years: 0, index: 1),
    AccountingExpModel(softwareName: 'AUS', years: 0, index: 2),
    AccountingExpModel(softwareName: 'CANADA', years: 0, index: 3),
    AccountingExpModel(softwareName: 'NZ', years: 0, index: 4),
    AccountingExpModel(softwareName: 'India', years: 0, index: 5),
  ];

  static List<SoftwareModel> softwareList = List()
    ..addAll([
      SoftwareModel(
          softwareName: 'Xero', /* percentage: 0, */ isCancelable: false),
      SoftwareModel(
        softwareName: 'QuickBook',
/*
        percentage: 0,
*/
        isCancelable: false,
      ),
      SoftwareModel(
          softwareName: 'Sage', /*percentage: 0, */ isCancelable: false),
      SoftwareModel(
          softwareName: 'Tally', /* percentage: 0,*/ isCancelable: false),
    ]);

  static final String STR_SELECT_HIGHEST_EDUCATION_QULIFICATION =
      "Select Highest Education Qulification";

  static final String STR_SOFTWARE_YOU_KNOW = "SOFTWARE Know";
}
