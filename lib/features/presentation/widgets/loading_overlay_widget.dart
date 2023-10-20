import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mytradeasia/config/themes/theme.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    // final spinkit = SpinKitFadingCircle(
    //   itemBuilder: (BuildContext context, int index) {
    //     return DecoratedBox(
    //       decoration: BoxDecoration(
    //         color: index.isEven ? Colors.red : Colors.green,
    //       ),
    //     );
    //   },
    // );
    return Stack(
      children: [
        // Grey background
        Opacity(
          opacity: 0.5,
          child: ModalBarrier(
            dismissible: false,
            color: Colors.grey[300],
          ),
        ),

        // Loading indicator
        Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: SpinKitFadingCircle(color: primaryColor1),
            ),
          ),
        ),
      ],
    );
  }
}
