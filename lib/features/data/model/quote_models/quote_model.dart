import 'package:mytradeasia/features/domain/entities/quote_entities/quote_entity.dart';

class QuoteModel extends QuoteEntity {
  const QuoteModel({
    required int id,
    required int salesId,
    required int rfqId,
    required int price,
    required String currency,
    required int quantity,
    required String unit,
    required String shipmentDate,
    required String validity,
    required String incoterm,
    required String paymentTerm,
    required String portOfDestination,
    required String note,
    required String quotationStatus,
  }) : super(
          id: id,
          salesId: salesId,
          rfqId: rfqId,
          price: price,
          currency: currency,
          quantity: quantity,
          unit: unit,
          shipmentDate: shipmentDate,
          validity: validity,
          incoterm: incoterm,
          paymentTerm: paymentTerm,
          portOfDestination: portOfDestination,
          note: note,
          quotationStatus: quotationStatus,
        );

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        id: json['id'],
        salesId: json['sales_id'],
        rfqId: json['rfq_id'],
        price: json['price'],
        currency: json['currency'],
        quantity: json['quantity'],
        unit: json['unit'],
        shipmentDate: json['shipment_date'],
        validity: json['validity'],
        incoterm: json['incoterm'],
        paymentTerm: json['payment_term'],
        portOfDestination: json['port_of_destination'],
        note: json['note'],
        quotationStatus: json['quotation_status'],
      );
}
