import 'package:mytradeasia/core/resources/data_state.dart';
import 'package:mytradeasia/features/domain/entities/quote_entities/quote_entity.dart';
import 'package:mytradeasia/features/domain/repository/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  @override
  Future<DataState<QuoteEntity>> getQuote(int id) {
    // TODO: implement getQuote
    throw UnimplementedError();
  }
}
