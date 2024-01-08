import 'package:equatable/equatable.dart';

class RfqEntity extends Equatable {
  final int? rfqId;
  final int custId;
  final int? salesId;
  final String? firstname;
  final String? lastname;
  final String? phone;
  final String? country;
  final String? company;
  final RfqProduct? products;
  final String? incoterm;
  final String? portOfDestination;
  final String? message;
  final String? quotationStatus;

  const RfqEntity(
      {required this.rfqId,
      required this.custId,
      this.salesId,
      this.firstname,
      this.lastname,
      this.phone,
      this.country,
      this.company,
      this.products,
      this.incoterm,
      this.portOfDestination,
      this.message,
      this.quotationStatus});

  Map<String, String> toRfqMap() {
    return {
      "First Name": firstname.toString(),
      "Last Name": lastname.toString(),
      "Phone Number": phone.toString(),
      "Country": country.toString(),
      "Company Name": company.toString(),
      "Product Name": products!.productName.toString(),
      "Quantity": products!.quantity.toString(),
      "Unit": products!.unit.toString(),
      "Incoterm": incoterm.toString(),
      "Port of Destination": portOfDestination.toString(),
      "Message": message.toString(),
    };
  }

  @override
  List<Object?> get props {
    return [
      rfqId,
      custId,
      salesId,
      firstname,
      lastname,
      phone,
      country,
      company,
      products,
      incoterm,
      portOfDestination,
      message,
      quotationStatus
    ];
  }
}

class RfqProduct {
  final String? productName;
  final double? quantity;
  final String? unit;

  const RfqProduct({
    this.productName,
    this.quantity,
    this.unit,
  });
}
