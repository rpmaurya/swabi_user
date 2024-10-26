import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cab/utils/assets.dart';
import 'package:flutter_cab/utils/color.dart';

class MultiImageSlider extends StatefulWidget {
  final List<String> images;

  const MultiImageSlider({super.key, required this.images});

  @override
  _MultiImageSliderState createState() => _MultiImageSliderState();
}

class _MultiImageSliderState extends State<MultiImageSlider> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    if (widget.images.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
        if (_currentPage < widget.images.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      });
    }
  }

  // Function to navigate to the previous page
  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  // Function to navigate to the next page
  void _nextPage() {
    if (_currentPage < widget.images.length - 1) {
      setState(() {
        _currentPage++;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
                width: double.infinity,
                child: Image.asset(tour, fit: BoxFit.fill))),
      );
    } else if (widget.images.length == 1) {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
              width: double.infinity,
              child: Image.network(widget.images[0], fit: BoxFit.fill)),
        ),
      );
    } else {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child:
                        Image.network(widget.images[index], fit: BoxFit.fill));
              },
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: _previousPage,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: background,
                    )),
                IconButton(
                    onPressed: _nextPage,
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: background,
                    ))
              ],
            ),
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      color:
                          _currentPage == index ? btnColor : bglightGreyColor,
                      border: Border.all(color: Colors.black87),
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      );
      // return CarouselSlider.builder(
      //   itemCount: widget.images.length,
      //   itemBuilder: (context, index, realIndex) {
      //     return ClipRRect(
      //         borderRadius: BorderRadius.circular(4),
      //         child: Image.network(widget.images[index], fit: BoxFit.fill));
      //   },
      //   options: CarouselOptions(
      //     aspectRatio: 2.0,
      //     viewportFraction: 1,
      //     enlargeCenterPage: true,
      //     autoPlay: true,
      //   ),
      // );
    }
    // return widget.images.length == 1
    //     ? SizedBox(width: double.infinity,child: Image.network(widget.images[0],fit: BoxFit.fill,))
    //     : PageView.builder(
    //   controller: _pageController,
    //   itemCount: widget.images.length,
    //   itemBuilder: (context, index) {
    //       return Image.network(widget.images[index], fit: BoxFit.fill,);
    //   },
    // );
  }
}
