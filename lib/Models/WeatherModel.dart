class WaetherResponseModel {
  String date;
  int temperatureC;
  int temperatureF;
  String summary;

  WaetherResponseModel(
      {this.date, this.temperatureC, this.temperatureF, this.summary});

  WaetherResponseModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    temperatureC = json['temperatureC'];
    temperatureF = json['temperatureF'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['temperatureC'] = this.temperatureC;
    data['temperatureF'] = this.temperatureF;
    data['summary'] = this.summary;
    return data;
  }
}

