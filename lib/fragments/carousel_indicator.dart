import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:weli/config/image.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<String?> imageSliders;

  const CarouselWithIndicator({
    required this.imageSliders,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider.builder(
        carouselController: _controller,
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 1,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            setState(() => _current = index);
          },
        ),
        itemCount: widget.imageSliders.length,
        itemBuilder: (context, index, realIndex) => Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(widget.imageSliders[index] ?? AppImage.defaultImageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.imageSliders
            .asMap()
            .entries
            .map(
              (entry) => GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1),
                    color: _current == entry.key ? Colors.black : Colors.white,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    ]);
  }
}
