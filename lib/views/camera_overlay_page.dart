// // lib/views/camera_overlay_page.dart
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CameraOverlayPage extends StatefulWidget {
//   const CameraOverlayPage({super.key});
//
//   @override
//   State<CameraOverlayPage> createState() => _CameraOverlayPageState();
// }
//
// class _CameraOverlayPageState extends State<CameraOverlayPage> {
//   CameraController? _controller;
//   bool _isReady = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initCamera();
//   }
//
//   Future<void> _initCamera() async {
//     final cameras = await availableCameras();
//     _controller = CameraController(cameras.first, ResolutionPreset.high);
//     await _controller!.initialize();
//     if (mounted) setState(() => _isReady = true);
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   Future<void> _capture() async {
//     if (_controller == null || !_controller!.value.isInitialized) return;
//     final file = await _controller!.takePicture();
//     Get.back(result: file.path); // ✅ path wapas bhejo
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_isReady || _controller == null) {
//       return const Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(child: CircularProgressIndicator(color: Colors.white)),
//       );
//     }
//
//     final size = MediaQuery.of(context).size;
//
//     // Box ki size — screen ke beech mein
//     final boxWidth = size.width * 0.85;
//     final boxHeight = boxWidth * (9 / 16); // 16:9 ratio — meter display jaisa
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // ── Camera Preview ──────────────────────────
//           SizedBox.expand(child: CameraPreview(_controller!)),
//
//           // ── Dark Overlay — box ke bahar ─────────────
//           ColorFiltered(
//             colorFilter: ColorFilter.mode(
//               Colors.black.withOpacity(0.6),
//               BlendMode.srcOut,
//             ),
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.black,
//                     backgroundBlendMode: BlendMode.dstOut,
//                   ),
//                 ),
//                 // ✅ Yahi transparent box hai
//                 Center(
//                   child: Container(
//                     width: boxWidth,
//                     height: boxHeight,
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // ── Box Border ──────────────────────────────
//           Center(
//             child: Container(
//               width: boxWidth,
//               height: boxHeight,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.greenAccent, width: 2),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//
//           // ── Guide Text ──────────────────────────────
//           Positioned(
//             top: size.height / 2 - boxHeight / 2 - 40,
//             left: 0,
//             right: 0,
//             child: const Text(
//               "Meter reading box ke andar align karo",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//
//           // ── Capture Button ──────────────────────────
//           Positioned(
//             bottom: 40,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: GestureDetector(
//                 onTap: _capture,
//                 child: Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.white, width: 4),
//                     color: Colors.white.withOpacity(0.2),
//                   ),
//                   child: const Icon(
//                     Icons.camera_alt,
//                     color: Colors.white,
//                     size: 32,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           // ── Back Button ─────────────────────────────
//           Positioned(
//             top: 40,
//             left: 16,
//             child: IconButton(
//               onPressed: () => Get.back(),
//               icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraOverlayPage extends StatefulWidget {
  const CameraOverlayPage({super.key});

  @override
  State<CameraOverlayPage> createState() => _CameraOverlayPageState();
}

class _CameraOverlayPageState extends State<CameraOverlayPage>
    with SingleTickerProviderStateMixin {
  CameraController? _controller;
  bool _isReady = false;
  bool _isFlashOn = false;
  double _zoomLevel = 1.0;
  double _minZoom = 1.0;
  double _maxZoom = 1.0;
  bool _isCapturing = false;
  String? _capturedPath;

  // Flash animation
  late AnimationController _flashAnimCtrl;
  late Animation<double> _flashAnim;

  @override
  void initState() {
    super.initState();
    _flashAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _flashAnim = Tween<double>(begin: 0, end: 1).animate(_flashAnimCtrl);
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _controller!.initialize();
    _minZoom = await _controller!.getMinZoomLevel();
    _maxZoom = await _controller!.getMaxZoomLevel();
    if (mounted) setState(() => _isReady = true);
  }

  @override
  void dispose() {
    _controller?.dispose();
    _flashAnimCtrl.dispose();
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    if (_controller == null) return;
    setState(() => _isFlashOn = !_isFlashOn);
    await _controller!.setFlashMode(
      _isFlashOn ? FlashMode.torch : FlashMode.off,
    );
  }

  Future<void> _setZoom(double zoom) async {
    if (_controller == null) return;
    final clampedZoom = zoom.clamp(_minZoom, _maxZoom);
    await _controller!.setZoomLevel(clampedZoom);
    setState(() => _zoomLevel = clampedZoom);
  }

  Future<void> _capture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (_isCapturing) return;

    setState(() => _isCapturing = true);

    // Flash animation
    _flashAnimCtrl.forward().then((_) => _flashAnimCtrl.reverse());

    final file = await _controller!.takePicture();

    // Flash off after capture
    if (_isFlashOn) {
      await _controller!.setFlashMode(FlashMode.off);
    }

    setState(() {
      _capturedPath = file.path;
      _isCapturing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady || _controller == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    // Agar photo capture ho gayi — preview dikhao
    if (_capturedPath != null) {
      return _PreviewPage(
        imagePath: _capturedPath!,
        onRetake: () => setState(() => _capturedPath = null),
        onUse: () => Get.back(result: _capturedPath),
      );
    }

    final size = MediaQuery.of(context).size;
    final boxWidth = size.width * 0.85;
    final boxHeight = boxWidth * (9 / 16);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── Camera Preview ──────────────────────────
          SizedBox.expand(child: CameraPreview(_controller!)),

          // ── Dark Overlay ────────────────────────────
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Center(
                  child: Container(
                    width: boxWidth,
                    height: boxHeight,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Corner Markers ──────────────────────────
          Center(
            child: SizedBox(
              width: boxWidth,
              height: boxHeight,
              child: Stack(
                children: [
                  // Top Left
                  Positioned(
                    top: 0,
                    left: 0,
                    child: _CornerMarker(corner: Corner.topLeft),
                  ),
                  // Top Right
                  Positioned(
                    top: 0,
                    right: 0,
                    child: _CornerMarker(corner: Corner.topRight),
                  ),
                  // Bottom Left
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: _CornerMarker(corner: Corner.bottomLeft),
                  ),
                  // Bottom Right
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: _CornerMarker(corner: Corner.bottomRight),
                  ),
                ],
              ),
            ),
          ),

          // ── Capture Flash Effect ─────────────────────
          AnimatedBuilder(
            animation: _flashAnim,
            builder: (_, __) => Opacity(
              opacity: _flashAnim.value * 0.7,
              child: Container(color: Colors.white),
            ),
          ),

          // ── Guide Text ──────────────────────────────
          Positioned(
            top: size.height / 2 - boxHeight / 2 - 48,
            left: 0,
            right: 0,
            child: const Text(
              "Meter reading box ke andar align karo",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                shadows: [Shadow(color: Colors.black, blurRadius: 4)],
              ),
            ),
          ),

          // ── Zoom Slider ──────────────────────────────
          Positioned(
            bottom: 140,
            left: 40,
            right: 40,
            child: Row(
              children: [
                const Icon(Icons.zoom_out, color: Colors.white, size: 20),
                Expanded(
                  child: Slider(
                    value: _zoomLevel,
                    min: _minZoom,
                    max: _maxZoom.clamp(_minZoom, 5.0),
                    onChanged: _setZoom,
                    activeColor: Colors.greenAccent,
                    inactiveColor: Colors.white38,
                  ),
                ),
                const Icon(Icons.zoom_in, color: Colors.white, size: 20),
              ],
            ),
          ),

          // ── Zoom Level Text ──────────────────────────
          Positioned(
            bottom: 130,
            left: 0,
            right: 0,
            child: Text(
              "${_zoomLevel.toStringAsFixed(1)}x",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),

          // ── Bottom Controls ──────────────────────────
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Flash Button
                GestureDetector(
                  onTap: _toggleFlash,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isFlashOn
                          ? Colors.yellow.withOpacity(0.3)
                          : Colors.white.withOpacity(0.15),
                      border: Border.all(
                        color: _isFlashOn ? Colors.yellow : Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      _isFlashOn ? Icons.flash_on : Icons.flash_off,
                      color: _isFlashOn ? Colors.yellow : Colors.white,
                      size: 24,
                    ),
                  ),
                ),

                // Capture Button
                GestureDetector(
                  onTap: _isCapturing ? null : _capture,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      color: _isCapturing
                          ? Colors.white.withOpacity(0.5)
                          : Colors.white.withOpacity(0.2),
                    ),
                    child: _isCapturing
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 32,
                          ),
                  ),
                ),

                // Placeholder — balance ke liye
                const SizedBox(width: 50, height: 50),
              ],
            ),
          ),

          // ── Back Button ─────────────────────────────
          Positioned(
            top: 44,
            left: 16,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Preview Page ─────────────────────────────────────────
class _PreviewPage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onRetake;
  final VoidCallback onUse;

  const _PreviewPage({
    required this.imagePath,
    required this.onRetake,
    required this.onUse,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Image Preview
          SizedBox.expand(
            child: Image.file(File(imagePath), fit: BoxFit.contain),
          ),

          // Bottom Buttons
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Row(
              children: [
                // Retake
                Expanded(
                  child: GestureDetector(
                    onTap: onRetake,
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.refresh, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "Retake",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Use Photo
                Expanded(
                  child: GestureDetector(
                    onTap: onUse,
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            "Use Photo",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Top label
          Positioned(
            top: 52,
            left: 0,
            right: 0,
            child: const Text(
              "Photo Preview",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Corner Marker ────────────────────────────────────────
enum Corner { topLeft, topRight, bottomLeft, bottomRight }

class _CornerMarker extends StatelessWidget {
  final Corner corner;
  const _CornerMarker({required this.corner});

  @override
  Widget build(BuildContext context) {
    const size = 20.0;
    const thickness = 3.0;
    const color = Colors.greenAccent;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CornerPainter(
          corner: corner,
          color: color,
          thickness: thickness,
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final Corner corner;
  final Color color;
  final double thickness;

  _CornerPainter({
    required this.corner,
    required this.color,
    required this.thickness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    switch (corner) {
      case Corner.topLeft:
        canvas.drawLine(Offset(0, h), Offset(0, 0), paint);
        canvas.drawLine(Offset(0, 0), Offset(w, 0), paint);
        break;
      case Corner.topRight:
        canvas.drawLine(Offset(0, 0), Offset(w, 0), paint);
        canvas.drawLine(Offset(w, 0), Offset(w, h), paint);
        break;
      case Corner.bottomLeft:
        canvas.drawLine(Offset(0, 0), Offset(0, h), paint);
        canvas.drawLine(Offset(0, h), Offset(w, h), paint);
        break;
      case Corner.bottomRight:
        canvas.drawLine(Offset(w, 0), Offset(w, h), paint);
        canvas.drawLine(Offset(w, h), Offset(0, h), paint);
        break;
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
