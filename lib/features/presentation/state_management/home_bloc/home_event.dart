abstract class HomeEvent {
  const HomeEvent();
}

class GetHomeDataEvent extends HomeEvent {
  const GetHomeDataEvent();
}

class DisposeHomeData extends HomeEvent {
  const DisposeHomeData();
}
