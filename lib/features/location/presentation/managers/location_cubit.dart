import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/features/location/data/model/location_model.dart';
import 'package:maqam_v2/features/location/domain/use_cases/fetch_location_use_case.dart';
import '../../../../di_container.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  static LocationCubit get(BuildContext context) => BlocProvider.of(context);

  LocationModel? locationModel;

  Future<void> getLocation() async {
    emit(LocationLoading());
    final res = await sl<FetchLocationUseCase>().call();
    return res.fold((l) {
      emit(LocationError(message: l.message));
      SnackBar(
        content: Text(l.message),
        backgroundColor: Colors.red,
      );
    }, (r) {
      locationModel = r;
      emit(LocationLoaded(model: r!));
    });
  }
}
