import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';

final batchApiModelProvider = Provider<BatchApiModel>(
  (ref) => BatchApiModel.empty(),
);

@JsonSerializable()
class BatchApiModel {
  @JsonKey(name: '_id')
  final String batchId;
  final String batchName;

  BatchApiModel({
    required this.batchId,
    required this.batchName,
  });

  // empty constructor
  BatchApiModel.empty()
      : batchId = '',
        batchName = '';

  //From JSON,
  factory BatchApiModel.fromJson(Map<String, dynamic> json) {
    return BatchApiModel(batchId: json['_id'], batchName: json['batchName']);
  }

  //to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': batchId,
      'batchName': batchName,
    };
  }

// Convert API object to Entity
  BatchEntity toEntity() => BatchEntity(
        batchId: batchId,
        batchName: batchName,
      );

  // Convert Entity to API Object
  BatchApiModel fromEntity(BatchEntity entity) => BatchApiModel(
        batchId: entity.batchId ?? '',
        batchName: entity.batchName,
      );

  // Convert API List to Entity List
  List<BatchEntity> toEntityList(List<BatchApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
