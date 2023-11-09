import 'package:mytradeasia/features/data/model/sales_force_data_models/sales_force_cp_model.dart';
import 'package:mytradeasia/features/domain/entities/product_entities/product_to_rfq_entity.dart';
import 'package:mytradeasia/features/domain/entities/searates_entities/searates_bl_entity.dart';

class TrackingDocumentParameter {
  String product;
  int indexProducts;
  TrackingDocumentParameter(
      {required this.product, required this.indexProducts});
}

class TrackingShipmentParameter {
  SearatesBLEntity data;

  TrackingShipmentParameter({required this.data});
}

class QuotationDetailParameter {
  String status;
  bool? isSales;
  QuotationDetailParameter({required this.status, this.isSales});
}

class MessageDetailParameter {
  String otherUserId;
  String currentUserId;
  String customerName;
  String chatId;
  String channelUrl;
  String? prodUrl;
  MessageDetailParameter(
      {required this.otherUserId,
      required this.currentUserId,
      required this.customerName,
      required this.chatId,
      required this.channelUrl,
      this.prodUrl});
}

class BiodataParameter {
  String email;
  String phone;
  BiodataParameter({required this.email, required this.phone});
}

class OtpVerificationParameter {
  String email;
  String phone;
  OtpVerificationParameter({required this.email, required this.phone});
}

class RequestQuotationParameter {
  List<ProductToRfq> products;
  RequestQuotationParameter({required this.products});
}

class OrderDetailParameter {
  CPRecords cpRecord;
  OrderDetailParameter({required this.cpRecord});
}
