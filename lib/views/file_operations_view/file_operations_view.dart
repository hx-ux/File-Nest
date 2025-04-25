import 'package:file_nest/views/controllers/HOME_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class File_Operation_Page extends GetView<HOME_Controller> {
  @override
  final controller = Get.put(HOME_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: CustomPaint(
            painter:
                ProgressBarPainter(progress: controller.transferProgress.value),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  Text(
                    "${((controller.transferProgress.value * 100).roundToDouble()).clamp(0, 100).toInt()}%",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    controller.currentProcressedFile.value.split('/').last,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressBarPainter extends CustomPainter {
  final double progress;

  ProgressBarPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = progress >= 1.0 ? Colors.green : Colors.blue
      ..style = PaintingStyle.fill;

    final rectHeight = size.height * progress;
    final rect =
        Rect.fromLTWH(0, size.height - rectHeight, size.width, rectHeight);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
      return true;
  }
}
