import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/domain/usecases/batch_usecase.dart';
import 'package:student_management_starter/features/batch/presentation/state/batch_state.dart';

final batchViewmodelProvider =
  StateNotifierProvider<BatchViewmodel, BatchState>(
    (ref) {
      return BatchViewmodel(ref.read(batchUsecaseProvider));
    },
  ); // StateNotifierProvider


class BatchViewmodel extends StateNotifier<BatchState> {
  BatchViewmodel(this.batchUseCase) : super(BatchState.initial());

  final BatchUseCase batchUseCase;

  addBatch(BatchEntity batch) async {
    // To show the progress bar
    state = state.copyWith(isLoading: true);

    var data = await batchUseCase.addBatch(batch);
    

    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        // Show the error message
      },
      (r) {
        state = state.copyWith(isLoading: false, error: null);
        // Show the success message
      },
    );
  }

  // For getting all batches
getAllBatches() async {
  // To show the progress bar
  state = state.copyWith(isLoading: true);
  var data = await batchUseCase.getAllBatches();

  data.fold(
    (l) {
      state = state.copyWith(isLoading: false, error: l.error);
      // Show the error message
    },
    (r) {
      state = state.copyWith(isLoading: false, lstBatches: r, error: null);
      // Show the success message or simply load data in UI
    },
  );
}

}
