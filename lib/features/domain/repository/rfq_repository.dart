import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class RfqRepository {
  Future<DataState<dynamic>> submitRfq(RfqEntity s);
  Future<DataState<List<RfqEntity>>> getRfqList();
  Future<DataState> approveQuote(int id);
  Future<DataState> rejectQuote(int id);
}
