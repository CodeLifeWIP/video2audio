import 'package:dartz/dartz.dart';
import 'package:video_to_audio/core/error/failure.dart';

abstract class UseCase<ResultType, Params> {
  Future<Either<Failure, ResultType>> call (Params params);
}