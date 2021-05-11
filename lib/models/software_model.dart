class SoftwareModel {
  String softwareName;

//  double percentage = 0;
  bool isEnabled;
  int index;

  SoftwareModel(
      {this.softwareName,
      this.isEnabled: false,
/*
      this.percentage: 0,
*/
      this.isCancelable = false,
      this.index: 0});

  bool isCancelable;
}
