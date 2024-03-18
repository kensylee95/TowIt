import 'package:json_annotation/json_annotation.dart';
part 'geo_location_model.g.dart';

@JsonSerializable()
class GeoLocationModel{
  double? latitude;
  double? longitude;
  String? city;
  String? country;
  String? address;
  GeoLocationModel({
    this.latitude, this.longitude, this.city, this.country, this.address,
  });
  factory GeoLocationModel.fromJson(Map<String, dynamic> json)=>_$GeoLocationModelFromJson(json);
  Map<String, dynamic> toJson()=>_$GeoLocationModelToJson(this);
}