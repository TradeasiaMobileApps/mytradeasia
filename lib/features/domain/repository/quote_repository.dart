import 'package:mytradeasia/features/domain/entities/quote_entities/quote_entity.dart';

import '../../../core/resources/data_state.dart';

abstract class QuoteRepository {
  Future<DataState<QuoteEntity>> getQuote(int id);
}
