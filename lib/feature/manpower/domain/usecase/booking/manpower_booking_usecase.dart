import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../manpower/manpower.dart';

class ManpowerBookingUseCase implements UseCase<dynamic, ManpowerEntities> {
  final ManpowerRepository _repository;
  ManpowerBookingUseCase(this._repository);

  @override
  Future<Either<Failure, dynamic>> call(
      ManpowerEntities manpowerEntities) async {
    return await _repository.manpowerBooking(manpowerEntities);
  }
}
