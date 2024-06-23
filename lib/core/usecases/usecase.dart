abstract class UserCase<T, P> {
  Future<T> call(P params);
}