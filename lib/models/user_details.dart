// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  final bool success;
  final String message;
  final Response response;

  UserDetails({
    required this.success,
    required this.message,
    required this.response,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    success: json["success"],
    message: json["message"],
    response: Response.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "response": response.toJson(),
  };
}

class Response {
  final List<ViewDetailDatum> viewDetailData;

  Response({
    required this.viewDetailData,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    viewDetailData: List<ViewDetailDatum>.from(json["viewdetaildata"].map((x) => ViewDetailDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "viewdetaildata": List<dynamic>.from(viewDetailData.map((x) => x.toJson())),
  };
}

class ViewDetailDatum {
  final int id;
  final int bookingId;
  final String poojaTitle;
  final String poojaDate;
  final String address;
  final String country;
  final String statename;
  final String cityname;
  final int pinCode;
  final int panditId;
  final String bookingPujaDate;
  final int bookingPaidAmount;
  final String orderId;
  final String pujaMode;
  final String pujaLanguage;
  final String pujaDuration;
  final String name;
  final String email;
  final String phone;
  final List<dynamic> sbdetail;

  ViewDetailDatum({
    required this.id,
    required this.bookingId,
    required this.poojaTitle,
    required this.poojaDate,
    required this.address,
    required this.country,
    required this.statename,
    required this.cityname,
    required this.pinCode,
    required this.panditId,
    required this.bookingPujaDate,
    required this.bookingPaidAmount,
    required this.orderId,
    required this.pujaMode,
    required this.pujaLanguage,
    required this.pujaDuration,
    required this.name,
    required this.email,
    required this.phone,
    required this.sbdetail,
  });

  factory ViewDetailDatum.fromJson(Map<String, dynamic> json) => ViewDetailDatum(
    id: json["id"],
    bookingId: json["booking_id"],
    poojaTitle: json["pooja_title"],
    poojaDate: json["pooja_date"],
    address: json["address"],
    country: json["country"],
    statename: json["statename"],
    cityname: json["cityname"],
    pinCode: json["pin_code"],
    panditId: json["pandit_id"],
    bookingPujaDate: json["booking_puja_date"],
    bookingPaidAmount: json["booking_paid_amount"],
    orderId: json["order_id"],
    pujaMode: json["puja_mode"],
    pujaLanguage: json["puja_language"],
    pujaDuration: json["puja_duration"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    sbdetail: List<dynamic>.from(json["sbdetail"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "pooja_title": poojaTitle,
    "pooja_date": poojaDate,
    "address": address,
    "country": country,
    "statename": statename,
    "cityname": cityname,
    "pin_code": pinCode,
    "pandit_id": panditId,
    "booking_puja_date": bookingPujaDate,
    "booking_paid_amount": bookingPaidAmount,
    "order_id": orderId,
    "puja_mode": pujaMode,
    "puja_language": pujaLanguage,
    "puja_duration": pujaDuration,
    "name": name,
    "email": email,
    "phone": phone,
    "sbdetail": List<dynamic>.from(sbdetail.map((x) => x)),
  };
}
