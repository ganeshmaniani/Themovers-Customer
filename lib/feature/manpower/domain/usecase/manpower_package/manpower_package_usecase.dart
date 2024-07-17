import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../manpower/manpower.dart';

class ManpowerPackageUseCase {
  final ManpowerRepository _repository;
  ManpowerPackageUseCase(this._repository);

  Future<Either<Failure, ManpowerPackageModel>> call() async {
    return await _repository.getManpowerPackageDetail();
  }
}
