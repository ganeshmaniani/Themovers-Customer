import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../disposal/disposal.dart';

class DisposalPackageUseCase {
  final DisposalRepository _repository;
  DisposalPackageUseCase(this._repository);

  Future<Either<Failure, DisposalPackageModel>> call() async {
    return await _repository.getDisposalPackageDetail();
  }
}
