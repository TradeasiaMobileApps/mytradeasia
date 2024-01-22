import 'package:equatable/equatable.dart';

class QuoteEntity extends Equatable {
  final int id;
  final int salesId;
  final int rfqId;
  final int price;
  final String currency;
  final int quantity;
  final String unit;
  final String shipmentDate;
  final String validity;
  final String incoterm;
  final String paymentTerm;
  final String portOfDestination;
  final String note;
  final String quotationStatus;

  const QuoteEntity({
    required this.id,
    required this.salesId,
    required this.rfqId,
    required this.price,
    required this.currency,
    required this.quantity,
    required this.unit,
    required this.shipmentDate,
    required this.validity,
    required this.incoterm,
    required this.paymentTerm,
    required this.portOfDestination,
    required this.note,
    required this.quotationStatus,
  });
  @override
  List<Object?> get props => [
        id,
        salesId,
        rfqId,
        price,
        currency,
        quantity,
        unit,
        shipmentDate,
        validity,
        incoterm,
        paymentTerm,
        portOfDestination,
        note,
        quotationStatus,
      ];

  Map<String, String> toQuoteMap() => {
        "Price": price.toString(),
        "Currency": currency.toString(),
        "Quantity": quantity.toString(),
        "UOM": unit.toString(),
        "Shipment Date": shipmentDate.toString(),
        "Validity": validity.toString(),
        "Incoterm": incoterm.toString(),
        "Payment Term": paymentTerm.toString(),
        "Port of Destination": portOfDestination.toString(),
        "Note": note.toString(),
      };
}
