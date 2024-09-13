import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cab/utils/assets.dart';

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

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
              width: double.infinity,
              child: Image.asset(tour, fit: BoxFit.fill)));
    } else if (widget.images.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
            width: double.infinity,
            child: Image.network(widget.images[0], fit: BoxFit.fill)),
      );
    } else {
      return PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(widget.images[index], fit: BoxFit.fill));
        },
      );
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
