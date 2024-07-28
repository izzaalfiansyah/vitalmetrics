import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:collection/collection.dart';

class Category {
  List<double> range;
  String result;
  Color color;

  Category({
    required this.range,
    required this.result,
    required this.color,
  });
}

class CategoryLabel extends StatefulWidget {
  final List<Category> categories;
  final double value;
  final bool graph;

  const CategoryLabel({
    super.key,
    required this.categories,
    required this.value,
    this.graph = false,
  });

  @override
  State<CategoryLabel> createState() => _CategoryLabelState();
}

class _CategoryLabelState extends State<CategoryLabel> {
  @override
  void initState() {
    super.initState();
  }

  Category? selected() {
    double value = widget.value;

    for (var category in widget.categories) {
      double minRange = category.range[0];
      double maxRange = category.range[1];

      if (value >= minRange && value <= maxRange) {
        return category;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (selected() != null && widget.value != 0) {
      final category = selected() as Category;

      if (widget.graph) {
        return Column(
          children: [
            linearGauge(category, isLabel: true),
            linearGauge(category),
          ],
        );
      }

      return Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(50),
            right: Radius.circular(50),
          ),
        ),
        child: Text(
          category.result,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white,
          ),
        ),
      );
    }

    return SizedBox();
  }

  SfLinearGauge linearGauge(Category category, {bool isLabel = false}) {
    return SfLinearGauge(
      showLabels: isLabel ? false : true,
      showTicks: false,
      // showAxisTrack: false,
      axisTrackStyle: LinearAxisTrackStyle(
        color: Colors.transparent,
      ),
      axisLabelStyle: TextStyle(
        color: Colors.grey,
        fontSize: 8,
      ),
      minimum: widget.categories[0].range[0],
      maximum: widget.categories[widget.categories.length - 1].range[1],
      ranges: widget.categories.mapIndexed(
        (i, el) {
          LinearEdgeStyle edgeStyle = LinearEdgeStyle.bothFlat;

          if (i == 0) {
            edgeStyle = LinearEdgeStyle.startCurve;
          }

          if (i == widget.categories.length - 1) {
            edgeStyle = LinearEdgeStyle.endCurve;
          }

          if (isLabel) {
            return LinearGaugeRange(
              startValue: el.range[0],
              endValue: el.range[1],
              color: Colors.transparent,
              startWidth: 14,
              endWidth: 14,
              position: LinearElementPosition.cross,
              edgeStyle: edgeStyle,
              child: Center(
                child: Text(
                  el.result,
                  style: TextStyle(
                    fontSize: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          }

          return LinearGaugeRange(
            startValue: el.range[0],
            endValue: el.range[1],
            color: el.color,
            startWidth: 8.5,
            endWidth: 8.5,
            position: LinearElementPosition.cross,
            edgeStyle: edgeStyle,
          );
        },
      ).toList(),
      markerPointers: !isLabel
          ? [
              LinearWidgetPointer(
                animationDuration: 0,
                value: widget.value,
                position: LinearElementPosition.cross,
                child: Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: category.color,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ]
          : [],
    );
  }
}
