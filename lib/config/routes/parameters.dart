import 'package:mytradeasia/features/domain/entities/product_entities/product_to_rfq_entity.dart';
import 'package:mytradeasia/features/domain/entities/searates_entities/searates_bl_entity.dart';

import '../../features/domain/entities/rfq_entities/rfq_entity.dart';

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
  RfqEntity? rfqEntity;
  QuotationDetailParameter(
      {required this.status, this.isSales, this.rfqEntity});
}

class MessageDetailParameter {
  String productId;
  String otherUserId;
  String currentUserId;
  String customerName;
  String chatId;
  String channelUrl;

  MessageDetailParameter({
    required this.productId,
    required this.otherUserId,
    required this.currentUserId,
    required this.customerName,
    required this.chatId,
    required this.channelUrl,
  });
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

class ProductsIndustryParameter {
  int index;
  String industryName;
  ProductsIndustryParameter({required this.index, required this.industryName});
}
