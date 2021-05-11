class ExpRequestModel{
  int countryId;
  int exp;
  ExpRequestModel({this.countryId, this.exp});

  Map toJson() => {
    'countryId': countryId,
    'exp': exp,
  };
}