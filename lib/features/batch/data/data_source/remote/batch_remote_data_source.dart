import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/app/constants/api_endpoint.dart';
import 'package:student_management_starter/core/networking/failure/failure.dart';
import 'package:student_management_starter/core/networking/remote/http_service.dart';
import 'package:student_management_starter/features/batch/data/dto/get_all_batch_dto.dart';
import 'package:student_management_starter/features/batch/data/model/batch_api_model.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';

final batchRemoteDataSourceProvider = Provider((ref) => BatchRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    batchApiModel: ref.read(batchApiModelProvider)));

class BatchRemoteDataSource {
  final Dio dio;
  final BatchApiModel batchApiModel;

  BatchRemoteDataSource({
    required this.dio, 
    required this.batchApiModel});



  // --------------ADD BATCHES_--------------------------------------

  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async {
    try {
      var response = await dio.post(
        ApiEndpoints.createBatch,
        data: batchApiModel.fromEntity(batch).toJson(),
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.message.toString(),
      ));
    }
  }


  //--------------------------------GET all bATCHES--###############################3-----------------

  Future<Either<Failure,List<BatchEntity>>> getAllBatches(BatchEntity batch) async {
    try{
      var response =await dio.get(ApiEndpoints.getAllBatch);
      if(response.statusCode==200){
        //2nd WAY
        GetAllBatchDTO batchAddDTO = GetAllBatchDTO.fromJson(response.data);
        return Right(batchApiModel.toEntityList(batchAddDTO.data));
      }else {
        return Left(
          Failure(
            error : response.statusMessage.toString(),
            statusCode : response.statusCode.toString(),
          ),
        );
      }
    }on DioException catch (e){
      return Left(
        Failure(
          error : e.error.toString(),
        )
      );
    }
  }

}