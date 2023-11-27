import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_entity.dart';

abstract class RfqEvent {
  const RfqEvent();
}

class SubmitRfqEvent extends RfqEvent {
  final RfqEntity rfqEntity;
  const SubmitRfqEvent(this.rfqEntity);
}
