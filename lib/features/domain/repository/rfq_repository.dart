import 'package:mytradeasia/features/domain/entities/rfq_entities/request_entity.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_list_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class RfqRepository {
  Future<DataState<dynamic>> submitRfq(RequestEntity s);
  Future<DataState<RfqListEntity>> getRfqList();
  Future<DataState> approveQuote(int id);
  Future<DataState> rejectQuote(int id);
}
