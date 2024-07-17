import 'package:dartz/dartz.dart';

import '../core.dart';

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}
