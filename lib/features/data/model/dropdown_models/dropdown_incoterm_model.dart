import 'package:mytradeasia/features/domain/entities/dropdown_entities/dropdown_incoterm_entity.dart';

class DropdownIncotermModel extends DropdownIncotermEntity {
  const DropdownIncotermModel({
    required int id,
    required String incotermName,
  }) : super(id: id, incotermName: incotermName);

  factory DropdownIncotermModel.fromJson(Map<String, dynamic> json) =>
      DropdownIncotermModel(
          id: json["id"], incotermName: json["incoterm_name"]);
}
