import 'package:bmi_calculator/providers/provider.dart';
import 'package:bmi_calculator/screens/bmi_calculator_page.dart';
import 'package:bmi_calculator/utils/colors.dart';
import 'package:bmi_calculator/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WeightScreen extends ConsumerWidget {
  const WeightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weight'),
          centerTitle: true,
          backgroundColor: primaryColor,
          foregroundColor: secondaryColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: R.sh(580, context),
              child: SfLinearGauge(
                orientation: LinearGaugeOrientation.vertical,
                maximum: 100,
                tickPosition: LinearElementPosition.outside,
                labelPosition: LinearLabelPosition.outside,
                minorTicksPerInterval: 0,
                interval: 25,
                axisTrackStyle: const LinearAxisTrackStyle(),
                markerPointers: [
                  LinearShapePointer(
                      value: ref.watch(weightProvider),
                      enableAnimation: false,
                      shapeType: LinearShapePointerType.rectangle,
                      color: primaryColor,
                      height: 1.5,
                      width: R.sw(250, context)),
                  LinearWidgetPointer(
                      value: ref.watch(weightProvider),
                      enableAnimation: false,
                      onChanged: (value) {
                        ref.read(weightProvider.notifier).state = value;
                      },
                      child: SizedBox(
                          width: R.sw(26, context),
                          height: R.sh(16, context),
                          child: Image.asset(
                            'assets/rectangle_pointer.png',
                            color: primaryColor,
                          ))),
                  LinearWidgetPointer(
                      value: ref.watch(weightProvider),
                      enableAnimation: false,
                      onChanged: (value) {
                        ref.read(weightProvider.notifier).state = value;
                      },
                      offset: R.sw(240, context),
                      position: LinearElementPosition.outside,
                      child: Container(
                          width: R.sw(64, context),
                          height: R.sh(34, context),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.circular(R.sw(4, context))),
                          child: Center(
                            child: Text(
                                '${ref.watch(weightProvider).toInt()} kg',
                                style: TextStyle(
                                    fontSize: R.sw(16, context),
                                    color: secondaryColor)),
                          ))),
                ],
                ranges: [
                  LinearGaugeRange(
                    endValue: ref.watch(weightProvider),
                    midWidth: R.sw(320, context),
                    color: Colors.transparent,
                    child: Image.asset(
                      "assets/human.png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: secondaryColor,
                  fixedSize: Size(R.sw(200, context), R.sh(50, context))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BmiCalculationScreen(),
                    ));
                ref.read(bmiclearProvider.notifier).state = false;
              },
              child: Text(
                'Next',
                style: TextStyle(fontSize: R.sw(22, context)),
              ),
            ),
          ],
        ));
  }
}
