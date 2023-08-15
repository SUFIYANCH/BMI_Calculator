import 'package:bmi_calculator/providers/provider.dart';
import 'package:bmi_calculator/utils/colors.dart';
import 'package:bmi_calculator/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BmiCalculationScreen extends ConsumerWidget {
  const BmiCalculationScreen({super.key});

  double calculateBMI(int height, int weight) {
    double bmi = weight / ((height / 100) * (height / 100));
    return bmi;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Result"),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: R.sh(240, context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: R.sw(24, context)),
                  child: Container(
                    height: R.sh(100, context),
                    padding: EdgeInsets.all(R.sw(20, context)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(R.sw(12, context)),
                        border: Border.all(
                            color: const Color.fromARGB(255, 225, 225, 225))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${ref.watch(heightProvider).toInt()} cm",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: R.sw(22, context)),
                            ),
                            const Text("Height")
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "${ref.watch(weightProvider).toInt()} kg",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: R.sw(22, context)),
                            ),
                            const Text("Weight")
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: secondaryColor,
                      fixedSize: Size(R.sw(250, context), R.sh(50, context))),
                  onPressed: () {
                    ref.read(bmiProvider.notifier).state = calculateBMI(
                      ref.watch(heightProvider).toInt(),
                      ref.watch(weightProvider).toInt(),
                    );
                    ref.read(bmiclearProvider.notifier).state = true;
                  },
                  child: Text(
                    'Calculate BMI',
                    style: TextStyle(fontSize: R.sw(20, context)),
                  ),
                ),
              ],
            ),
          ),
          ref.watch(bmiclearProvider)
              ? SizedBox(
                  height: R.sh(380, context),
                  child: Stack(alignment: Alignment.center, children: [
                    Container(
                      height: R.sh(200, context),
                      width: R.sw(200, context),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: Text(
                        ref.watch(bmiProvider).toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: R.sw(50, context),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    SfRadialGauge(axes: [
                      RadialAxis(
                        radiusFactor: R.sw(0.7, context),
                        showLabels: false,
                        showTicks: false,
                        startAngle: 0,
                        endAngle: 360,
                        minimum: 0,
                        maximum: 1,
                        pointers: [
                          RangePointer(
                            enableAnimation: true,
                            enableDragging: true,
                            cornerStyle: CornerStyle.bothFlat,
                            color: primaryColor,
                            value: 0.5,
                            width: R.sw(24, context),
                          ),
                        ],
                        axisLineStyle: AxisLineStyle(
                            thickness: R.sw(24, context),
                            color: Colors.grey.withOpacity(0.2)),
                      ),
                    ]),
                  ]),
                )
              : SizedBox(),
          ref.watch(bmiclearProvider)
              ? bmiConditions(ref.watch(bmiProvider), context)
              : SizedBox(),
        ],
      ),
    );
  }
}

Widget bmiConditions(double bmivalue, BuildContext context) {
  if (bmivalue >= 40) {
    return Text(
      "You are Morbidly Obese",
      style:
          TextStyle(fontSize: R.sw(20, context), fontWeight: FontWeight.bold),
    );
  } else if (bmivalue >= 35) {
    return Text(
      "You are Severely Obese",
      style:
          TextStyle(fontSize: R.sw(20, context), fontWeight: FontWeight.bold),
    );
  } else if (bmivalue >= 30) {
    return Text(
      "You are Moderately Obese",
      style:
          TextStyle(fontSize: R.sw(20, context), fontWeight: FontWeight.bold),
    );
  } else if (bmivalue >= 25) {
    return Text(
      "You are Overweight",
      style:
          TextStyle(fontSize: R.sw(20, context), fontWeight: FontWeight.bold),
    );
  } else if (bmivalue >= 18.5) {
    return Text(
      "You have Normal body weight",
      style:
          TextStyle(fontSize: R.sw(20, context), fontWeight: FontWeight.bold),
    );
  } else if (bmivalue >= 16) {
    return Text(
      "You are Underweight",
      style:
          TextStyle(fontSize: R.sw(20, context), fontWeight: FontWeight.bold),
    );
  } else if (bmivalue > 0) {
    return Text(
      "You are Severely Underweight",
      style:
          TextStyle(fontSize: R.sw(20, context), fontWeight: FontWeight.bold),
    );
  } else {
    return const Text("");
  }
}
