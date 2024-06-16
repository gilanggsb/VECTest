// To parse this JSON data, do
//
//     final productRating = productRatingFromJson(jsonString);

import 'dart:convert';

List<ProductRating> productRatingFromJson(String str) =>
    List<ProductRating>.from(
        json.decode(str).map((x) => ProductRating.fromJson(x)));

String productRatingToJson(List<ProductRating> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductRating {
  final String? id;
  final DateTime? createdAt;
  final String? review;
  final int? rating;
  final bool? isAnonymous;
  final String? status;
  final String? productName;
  final String? invoiceNumber;
  final User? user;

  ProductRating({
    this.id,
    this.createdAt,
    this.review,
    this.rating,
    this.isAnonymous,
    this.status,
    this.productName,
    this.invoiceNumber,
    this.user,
  });

  factory ProductRating.fromJson(Map<String, dynamic> json) => ProductRating(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        review: json["review"],
        rating: json["rating"],
        isAnonymous: json["is_anonymous"],
        status: json["status"],
        productName: json["product_name"],
        invoiceNumber: json["invoice_number"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "review": review,
        "rating": rating,
        "is_anonymous": isAnonymous,
        "status": status,
        "product_name": productName,
        "invoice_number": invoiceNumber,
        "user": user?.toJson(),
      };
}

class User {
  final String? name;
  final String? email;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;
  final String? phoneNumber;
  final String? profilePicture;
  final String? role;
  final String? placeOfBirth;
  final DateTime? dateOfBirth;
  final String? description;
  final String? gender;
  final dynamic strNumber;
  final dynamic deletedAt;
  final String? csPhoneNumber;
  final int? height;
  final int? weight;
  final String? fcmToken;
  final dynamic clinicBranchId;
  final dynamic icountClinicBusinessPartnerId;
  final dynamic csOfficeNumber;
  final dynamic queueNumber;
  final bool? isReady;
  final bool? isAllProduct;
  final dynamic customerServiceId;
  final dynamic activeDates;
  final String? countryCode;
  final int? totalClinicTransaction;
  final int? totalOnlineStoreTransaction;
  final int? totalAmountClinicTransaction;
  final int? totalAmountOnlineStoreTransaction;

  User({
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.phoneNumber,
    this.profilePicture,
    this.role,
    this.placeOfBirth,
    this.dateOfBirth,
    this.description,
    this.gender,
    this.strNumber,
    this.deletedAt,
    this.csPhoneNumber,
    this.height,
    this.weight,
    this.fcmToken,
    this.clinicBranchId,
    this.icountClinicBusinessPartnerId,
    this.csOfficeNumber,
    this.queueNumber,
    this.isReady,
    this.isAllProduct,
    this.customerServiceId,
    this.activeDates,
    this.countryCode,
    this.totalClinicTransaction,
    this.totalOnlineStoreTransaction,
    this.totalAmountClinicTransaction,
    this.totalAmountOnlineStoreTransaction,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        id: json["id"],
        phoneNumber: json["phone_number"],
        profilePicture: json["profile_picture"],
        role: json["role"],
        placeOfBirth: json["place_of_birth"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        description: json["description"],
        gender: json["gender"],
        strNumber: json["str_number"],
        deletedAt: json["deleted_at"],
        csPhoneNumber: json["cs_phone_number"],
        height: json["height"],
        weight: json["weight"],
        fcmToken: json["fcm_token"],
        clinicBranchId: json["clinic_branch_id"],
        icountClinicBusinessPartnerId:
            json["icount_clinic_business_partner_id"],
        csOfficeNumber: json["cs_office_number"],
        queueNumber: json["queue_number"],
        isReady: json["is_ready"],
        isAllProduct: json["is_all_product"],
        customerServiceId: json["customer_service_id"],
        activeDates: json["active_dates"],
        countryCode: json["country_code"],
        totalClinicTransaction: json["total_clinic_transaction"],
        totalOnlineStoreTransaction: json["total_online_store_transaction"],
        totalAmountClinicTransaction: json["total_amount_clinic_transaction"],
        totalAmountOnlineStoreTransaction:
            json["total_amount_online_store_transaction"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "id": id,
        "phone_number": phoneNumber,
        "profile_picture": profilePicture,
        "role": role,
        "place_of_birth": placeOfBirth,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "description": description,
        "gender": gender,
        "str_number": strNumber,
        "deleted_at": deletedAt,
        "cs_phone_number": csPhoneNumber,
        "height": height,
        "weight": weight,
        "fcm_token": fcmToken,
        "clinic_branch_id": clinicBranchId,
        "icount_clinic_business_partner_id": icountClinicBusinessPartnerId,
        "cs_office_number": csOfficeNumber,
        "queue_number": queueNumber,
        "is_ready": isReady,
        "is_all_product": isAllProduct,
        "customer_service_id": customerServiceId,
        "active_dates": activeDates,
        "country_code": countryCode,
        "total_clinic_transaction": totalClinicTransaction,
        "total_online_store_transaction": totalOnlineStoreTransaction,
        "total_amount_clinic_transaction": totalAmountClinicTransaction,
        "total_amount_online_store_transaction":
            totalAmountOnlineStoreTransaction,
      };
}
