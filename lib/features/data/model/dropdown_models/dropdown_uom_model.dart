import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_uom_entity.dart';

class DropdownUomModel extends DropdownUomEntity {
  const DropdownUomModel({
    required int id,
    required String uomName,
  }) : super(id: id, uomName: uomName);

  factory DropdownUomModel.fromJson(Map<String, dynamic> json) =>
      DropdownUomModel(
        id: json["id"],
        uomName: json["uom_name"],
      );
}
