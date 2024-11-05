import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.storage(String message) = StorageFailure;
  const factory Failure.server(String message) = ServerFailure;
  const factory Failure.cache(String message) = CacheFailure;
}
