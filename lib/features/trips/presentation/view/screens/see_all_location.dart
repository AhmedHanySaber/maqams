import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/widgets/custom_appbar.dart';
import 'package:maqam_v2/features/trips/data/model/trip_model.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_cubit.dart';
import 'package:maqam_v2/features/trips/presentation/controllers/trips_state.dart';
import 'package:maqam_v2/features/trips/presentation/view/widgets/location_list_view.dart';

import '../../../../../di_container.dart';

class SeeAllLocationScreen extends StatefulWidget {
  final List<TripModel> trips;

  const SeeAllLocationScreen({super.key, required this.trips});

  @override
  State<SeeAllLocationScreen> createState() => _SeeAllLocationScreenState();
}

class _SeeAllLocationScreenState extends State<SeeAllLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "All Locations".tr, isRoot: false),
      body: BlocConsumer<TripsCubit, TripsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = sl<TripsCubit>();
          return LocationGridView(
              future: cubit.getLocation(), trips: widget.trips);
        },
      ),
    );
  }
}
