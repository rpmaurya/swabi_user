import 'package:flutter/material.dart';
import 'package:flutter_cab/res/customTextWidget.dart';
import 'package:flutter_cab/utils/color.dart';

class CustomGridView extends StatelessWidget {
  final List<String> gridImages;
  final VoidCallback onTap;
  const CustomGridView(
      {Key? key, required this.gridImages, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: gridImages.length,
      itemBuilder: (context, index) {
        return Material(
          borderRadius: BorderRadius.circular(10),
          color: bgGreyColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    SizedBox(
                      height: double.infinity,
                      child: Image.asset(gridImages[index], fit: BoxFit.fill),
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: background),
                        child: const CustomText(
                          content: "HOTELS",
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 1),
                            decoration: const BoxDecoration(color: background),
                            child: const CustomText(
                              content: "PRICE DROP ALERT",
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                              width: 190,
                              child: CustomText(
                                align: TextAlign.start,
                                content:
                                    "Grab Up to 25% OFF* on Internation Hotels",
                                textColor: background,
                                fontWeight: FontWeight.w600,
                                maxline: 2,
                              )),
                          const CustomText(
                              content: "& plan your 15-19 Aug weekend trip",
                              textColor: background,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              maxline: 2),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}
