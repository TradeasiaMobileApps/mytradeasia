abstract class SearatesBLEvent {
  const SearatesBLEvent();
}

class TrackByBLNumber extends SearatesBLEvent {
  final String number;
  TrackByBLNumber(this.number);
}
