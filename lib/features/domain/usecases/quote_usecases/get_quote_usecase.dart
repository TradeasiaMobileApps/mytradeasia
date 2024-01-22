import 'package:mytradeasia/core/usecase/usecase.dart';
import 'package:mytradeasia/features/domain/entities/quote_entities/quote_entity.dart';
import 'package:mytradeasia/features/domain/repository/quote_repository.dart';

import '../../../../core/resources/data_state.dart';

class GetQuote implements UseCase<DataState<QuoteEntity>, int> {
  final QuoteRepository _quoteRepository;

  GetQuote(this._quoteRepository);

  /// Performs the use case operation in which @param is refering for quote id
  @override
  Future<DataState<QuoteEntity>> call({required int param}) async {
    return _quoteRepository.getQuote(param);
  }
}
