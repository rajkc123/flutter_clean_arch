import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/networking/failure/failure.dart';
import 'package:student_management_starter/features/batch/data/data_source/local/batch_local_datasource.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/domain/repository/batch_repository.dart';

final batchRemoteRepositoryProvider = Provider<IBatchRepository>((ref) {
  return BatchRemoteRepository(
    batchLocalDataSource: ref.read(batchLocalDataSourceProvider),
  );
});

class BatchRemoteRepository implements IBatchRepository {
  // to call localdatasource Add and Get batches function
  final BatchLocalDataSource batchLocalDataSource;
  BatchRemoteRepository({required this.batchLocalDataSource});

  @override
  Future<Either<Failure, bool>> addBatch(BatchEntity batch) {
    return batchLocalDataSource.addBatch(batch);
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() {
    return batchLocalDataSource.getAllBatches();
  }
}
