abstract class QuotationEvent {
  const QuotationEvent();
}

class GetRFQs extends QuotationEvent {
  const GetRFQs();
}

class DisposeQuotation extends QuotationEvent {
  const DisposeQuotation();
}
