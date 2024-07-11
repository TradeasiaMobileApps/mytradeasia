import 'package:mytradeasia/features/domain/entities/rfq_entities/rfq_entity.dart';

class RfqListEntity {
  final List<RfqEntity>? submitted;
  final List<RfqEntity>? quoted;
  final List<RfqEntity>? approved;
  final List<RfqEntity>? rejected;

  const RfqListEntity(
      {this.submitted, this.quoted, this.approved, this.rejected});
}
