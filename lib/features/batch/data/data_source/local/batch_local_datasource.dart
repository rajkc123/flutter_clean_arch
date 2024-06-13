import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/networking/failure/failure.dart';
import 'package:student_management_starter/core/networking/local/hive_service.dart';
import 'package:student_management_starter/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';

//Create a provider for the BatchLocalDataSource
final batchLocalDataSourceProvider = Provider(
  (ref) => BatchLocalDataSource(
    hiveService: ref.read(hiveServiceProvider),
    batchHiveModel: ref.read(batchHiveModelProvider),
  ),
);

class BatchLocalDataSource {
  final HiveService hiveService;
  final BatchHiveModel batchHiveModel;

  BatchLocalDataSource({
    required this.hiveService,
    required this.batchHiveModel,
  });

// ======================Add Batch===============================================

  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async {
    try {
      //convert Entity to Hive Object
      final hiveBatch = batchHiveModel.fromEntity(batch);
      //add to hive
      await hiveService.addBatch(hiveBatch);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

//===================Get All Batches===================================

Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
  try {
    //Get All Batches from Hive
    final hiveBatches = await hiveService.getAllBatches();

    //Convert hive List to Entity 
    //

    final batches = batchHiveModel.toEntityList(hiveBatches);
    return Right(batches);
  }catch (e){
    return Left(Failure(error: e.toString()));
  }
}



}


