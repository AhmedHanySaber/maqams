import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqam_v2/features/search/domain/use_case/search_use_case.dart';
import 'package:maqam_v2/features/search/presentation/controllers/search_state.dart';
import 'package:maqam_v2/features/trips/data/model/trip_model.dart';
import '../../../../di_container.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);

  Stream<Iterable<TripModel>> streamTripsByName({required String name}) async* {
    final resultStream = sl<FetchSearchTripsUseCase>().call(name);
    await for (final result in resultStream) {
      yield* result.fold(
        (failure) async* {
          print(failure.message);
          throw failure;
        },
        (trips) async* {
          yield trips;
        },
      );
    }
  }
}
