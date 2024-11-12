import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maqam_v2/core/utils/app_fonts.dart';
import 'package:maqam_v2/features/trips/presentation/view/widgets/trip_widget.dart';
import '../../../../../core/utils/colors.dart';
import '../../../data/model/trip_model.dart';
import 'details_screen.dart';

class AllTripsScreen extends StatelessWidget {
  final List<TripModel> trips;
  final String categoryName;

  const AllTripsScreen(
      {super.key, required this.trips, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          categoryName,
          style: AppFontStyle.primaryBold_22,
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .79,
            crossAxisCount: 2,
            crossAxisSpacing: 9,
            mainAxisSpacing: 10,
          ),
          itemCount: trips.length,
          itemBuilder: (context, index) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(trip: trips[index]),
                    ),
                  );
                },
                child: TripWidget2(
                  image: trips[index].images[0],
                  location: trips[index].location,
                  title: trips[index].name,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
