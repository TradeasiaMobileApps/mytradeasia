import 'package:mytradeasia/features/domain/entities/rfq_entities/request_entity.dart';
import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_entity.dart';

abstract class RfqEvent {
  const RfqEvent();
}

class DisposeRfq extends RfqEvent {}

class SubmitRfqEvent extends RfqEvent {
  final RequestEntity rfqEntity;
  const SubmitRfqEvent(this.rfqEntity);
}
