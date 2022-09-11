class PurchaseHistory {
  String? userEmail;
  int? id;
  String? destination;
  int? destinationID;
  int? totalPerson;
  String? startDate;
  String? endDate;
  int? duration;
  int? hotelType;
  int? transportationMode;
  int? totalCost;
  static const tableName = 'history';

  PurchaseHistory(
      {this.userEmail,
      this.id,
      this.destination,
      this.totalPerson,
      this.startDate,
      this.endDate,
      this.hotelType,
      this.transportationMode,
      this.totalCost,
      this.duration});

  static PurchaseHistory fromMap(Map<String, dynamic> json) {
    return PurchaseHistory(
      userEmail: json['userEmail'].toString(),
      id: json['id'],
      destination: json['destination'].toString(),
      totalPerson: json['totalPerson'],
      startDate: json['startDate'].toString(),
      endDate: json['endDate'].toString(),
      hotelType: json['hotelType'],
      transportationMode: json['transportationMode'],
      totalCost: json['totalCost'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'userEmail': userEmail,
      'id': id,
      "destination": destination,
      "totalPerson": totalPerson,
      "startDate": startDate,
      "endDate": endDate,
      "hotelType": hotelType,
      "transportationMode": transportationMode,
      "totalCost": totalCost,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  String getHotelTypeByID(int id) {
    if (id == 0) {
      return "Budget Friendly";
    } else if (id == 1) {
      return "Moderate";
    } else {
      return "Luxury";
    }
  }

  String getTransportModeByID(int id) {
    if (id == 0) {
      return "By Air";
    } else if (id == 1) {
      return "By Car";
    } else {
      return "By Bus";
    }
  }
}
