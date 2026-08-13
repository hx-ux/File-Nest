import 'package:file_nest/views/controllers/HOME_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileTransferView extends GetView<HomeController> {
  @override
  // final controller = Get.put(HOME_Controller());
  const FileTransferView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Obx(
        () => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: CustomPaint(
            painter:
                ProgressBarPainter(
              progress: controller.transferProgress.value,
              color: colorScheme.primary,
              completeColor: colorScheme.secondary,
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  Text(
                    "${((controller.transferProgress.value * 100).roundToDouble()).clamp(0, 100).toInt()}%",
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    controller.currentProcressedFile.value.split('/').last,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
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
  final Color color;
  final Color completeColor;

  ProgressBarPainter({
    required this.progress,
    required this.color,
    required this.completeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = progress >= 1.0 ? completeColor : color
      ..style = PaintingStyle.fill;

    final rectHeight = size.height * progress.clamp(0.0, 1.0);
    final rect =
        Rect.fromLTWH(0, size.height - rectHeight, size.width, rectHeight);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
