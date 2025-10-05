// Base interfaces for all app

abstract class BaseRepository {
  void dispose() {}
}

abstract class BaseDataSource {
  void dispose() {}
}

abstract class BaseUseCase<T, Params> {
  Future<T> call(Params params);
}

class NoParams {
  const NoParams();
}