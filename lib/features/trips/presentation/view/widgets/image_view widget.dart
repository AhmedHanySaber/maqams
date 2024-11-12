import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/utils/colors.dart';

class ImageViwer extends StatelessWidget {
  final List<String> image;

  const ImageViwer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: image.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: SizedBox(
              height: 300,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FancyShimmerImage(
                  shimmerHighlightColor: AppColors.primaryColor.withOpacity(.6),
                  shimmerBaseColor: AppColors.primaryColor.withOpacity(.2),
                  imageUrl: image[index],
                  errorWidget: Image.asset('assets/images/error.png'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
