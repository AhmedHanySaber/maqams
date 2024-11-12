import 'package:flutter/material.dart';
import 'package:maqam_v2/core/utils/colors.dart';
import '../../../domain/entity/maqam_entity.dart';
import '../widgets/image_view widget.dart';


class ImageDetailsScreen extends StatelessWidget {
  final MaqamEntity maqam;

  const ImageDetailsScreen({super.key, required this.maqam});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20.0,
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ImageViwer(
                          image: maqam.images,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              //   child: SizedBox(
              //     height: MediaQuery.of(context).size.height * .1,
              //     child: ListView.separated(
              //       itemCount: 7,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) {
              //         return InkWell(
              //           onTap: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (_) => DetailsScreen(trip: trip)));
              //           },
              //           child: ClipOval(
              //             child: Container(
              //               width: MediaQuery.of(context).size.height * .1,
              //               decoration: BoxDecoration(
              //                   image: DecorationImage(
              //                       fit: BoxFit.fitHeight,
              //                       image: NetworkImage(trip.images[0]))),
              //             ),
              //           ),
              //         );
              //       },
              //       separatorBuilder: (context, index) {
              //         return const SizedBox(width: 10);
              //       },
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  maqam.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        maqam.trip,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: 343,
                child: Text(
                  maqam.description,
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(
      //     horizontal: 12,
      //     vertical: 20,
      //   ),
      //   child: ElevatedButton(
      //     onPressed: () async {
      //       // await TripRepository().addToCart(trip);
      //     },
      //     style: ElevatedButton.styleFrom(
      //       foregroundColor: Colors.white,
      //       backgroundColor: Green,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(20),
      //       ),
      //     ),
      //     child: const Text("Booking Now",
      //         style: TextStyle(
      //           fontSize: 20,
      //           fontWeight: FontWeight.bold,
      //         )),
      //   ),
      // ),
    );
  }
}