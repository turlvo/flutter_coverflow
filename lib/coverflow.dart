library coverflow;

import 'package:flutter/material.dart';

class CoverFlow extends StatefulWidget {
  final List<String> titles;
  final List<Widget> images;
  final TextStyle textStyle;
  final bool displayOnlyCenterTitle;
  final Function onCenterItemSelected;

  CoverFlow({
    @required this.images,
    this.titles,
    this.onCenterItemSelected,
    this.textStyle,
    this.displayOnlyCenterTitle = false,
  });

  @override
  _CoverFlowState createState() => _CoverFlowState();
}

class _CoverFlowState extends State<CoverFlow> {
  PageController _pageController;
  double _currentPagePosition = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPagePosition.toInt());
    _pageController.addListener(
      () {
        setState(() {
          _currentPagePosition = _pageController.page ?? 0;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double centerWidgetWidth = constraints.maxWidth / 4;
          final double nearWidgetWidth = centerWidgetWidth / 5 * 4;
          final double farWidgetWidth = centerWidgetWidth / 5 * 3;

          return GestureDetector(
            onTapUp: (detail) {
              final double centerPosition = constraints.maxWidth / 2;

              final double centerLeftEdge =
                  centerPosition - centerWidgetWidth / 2;
              final double centerRightEdge =
                  centerPosition + centerWidgetWidth / 2;

              if (detail.localPosition.dx <= centerLeftEdge) {
                _pageController.animateToPage(_currentPagePosition.toInt() - 1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              } else if (detail.localPosition.dx >= centerRightEdge) {
                _pageController.animateToPage(_currentPagePosition.toInt() + 1,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              } else {
                widget.onCenterItemSelected(_currentPagePosition.toInt());
              }
            },
            child: Stack(
              children: <Widget>[
                CoverFlowCardItems(
                  images: widget.images,
                  titles: widget.titles,
                  textStyle: widget.textStyle,
                  currentPagePosition: _currentPagePosition,
                  maxWidth: constraints.maxWidth,
                  maxHeight: constraints.maxHeight,
                  displayOnlyCenterTitle: widget.displayOnlyCenterTitle,
                  centerWidgetWidth: centerWidgetWidth,
                  nearWidgetWidth: nearWidgetWidth,
                  farWidgetWidth: farWidgetWidth,
                ),
                Positioned.fill(
                  child: PageView.builder(
                    itemCount: widget.images.length,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CoverFlowCardItems extends StatelessWidget {
  final List<Widget> images;
  final List<String> titles;
  final double currentPagePosition;
  final double maxHeight;
  final double maxWidth;
  final TextStyle textStyle;
  final bool displayOnlyCenterTitle;
  final double centerWidgetWidth;
  final double nearWidgetWidth;
  final double farWidgetWidth;

  CoverFlowCardItems({
    @required this.images,
    @required this.titles,
    @required this.currentPagePosition,
    @required this.maxHeight,
    @required this.maxWidth,
    @required this.centerWidgetWidth,
    @required this.nearWidgetWidth,
    @required this.farWidgetWidth,
    this.textStyle,
    this.displayOnlyCenterTitle,
  });

  double getCardPosition(int index) {
    final double center = maxWidth / 2;
    final double basePosition = center - centerWidgetWidth / 2;

    final distance = currentPagePosition - index;

    if (distance == 0) {
      return basePosition;
    } else if (distance.abs() > 0.0 && distance.abs() <= 1.0) {
      if (distance > 0) {
        return basePosition - nearWidgetWidth * distance.abs();
      } else {
        return basePosition + centerWidgetWidth * distance.abs();
      }
    } else if (distance.abs() >= 1.0 && distance.abs() <= 2.0) {
      if (distance > 0) {
        return (basePosition - nearWidgetWidth) -
            farWidgetWidth * (distance.abs() - 1);
      } else {
        return (basePosition + centerWidgetWidth + nearWidgetWidth) +
            farWidgetWidth * (distance.abs() - 2) -
            (nearWidgetWidth - farWidgetWidth) *
                ((distance - distance.floor()));
      }
    } else {
      if (distance > 0) {
        return (basePosition - nearWidgetWidth) -
            farWidgetWidth * (distance.abs() - 1);
      } else {
        return (basePosition + centerWidgetWidth + nearWidgetWidth) +
            farWidgetWidth * (distance.abs() - 2);
      }
    }
  }

  double getCardWidth(int index) {
    final double distance = (currentPagePosition - index).abs();

    if (distance >= 0.0 && distance < 1.0) {
      return centerWidgetWidth -
          (centerWidgetWidth - nearWidgetWidth) * (distance - distance.floor());
    } else if (distance >= 1.0 && distance < 2.0) {
      return nearWidgetWidth -
          (nearWidgetWidth - farWidgetWidth) * (distance - distance.floor());
    } else {
      return farWidgetWidth;
    }
  }

  Matrix4 getTransform(int index) {
    final distance = currentPagePosition - index;

    return Matrix4.identity()
      ..setEntry(3, 2, 0.007)
      ..rotateY(-0.15 * distance);
  }

  double getFontSize(int index) {
    final double distance = (currentPagePosition - index).abs();
    final defaultFontSize = 20.0;

    if (displayOnlyCenterTitle) return 20.0;

    if (distance >= 0 && distance < 1.0) {
      return (defaultFontSize - 5 * (distance - distance.floor()));
    } else if (distance >= 0 && distance < 2.0) {
      return (defaultFontSize - 7 - 5 * (distance - distance.floor()));
    } else {
      return (defaultFontSize - 12 - 10 * (distance - distance.floor()));
    }
  }

  Widget _buildTitle(index) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          titles[index],
          style: textStyle != null
              ? textStyle.copyWith(fontSize: getFontSize(index))
              : TextStyle(
                  fontSize: getFontSize(index),
                  color: Colors.black,
                ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Widget _buildReflectionWidget(
  //     double width, double height, int index, Widget child) {
  //   return Transform(
  //     // Transform widget
  //     transform: getTransform(index),
  //     alignment: FractionalOffset.center,
  //     child: Container(
  //       height: currentPagePosition == index ? height + 10 : height,
  //       width: width,
  //       child: child,
  //     ), // <<< set your widget here
  //   );
  // }

  Widget _buildItem(Widget item) {
    final int index = images.indexOf(item);
    final width = getCardWidth(index);
    // final height = maxHeight - 20 * (currentPagePosition - index).abs();
    final position = getCardPosition(index);

    return Positioned(
      left: position,
      child: Transform(
        transform: getTransform(index),
        alignment: FractionalOffset.center,
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.red,
                width: width.toDouble(),
                child: item,
              ),
              if (titles != null && !displayOnlyCenterTitle) _buildTitle(index),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.center,
        clipBehavior: Clip.none,
        children: <Widget>[
          ...images.map<Widget>((item) {
            return _buildItem(item);
          }).toList(),
          if (titles != null && displayOnlyCenterTitle)
            _buildTitle(currentPagePosition.toInt()),
        ],
      ),
    );
  }
}
