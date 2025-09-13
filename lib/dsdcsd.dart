// class RPSCustomPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Layer 1

//     Paint paint_fill_0 = Paint()
//       ..color = const Color.fromARGB(255, 0, 0, 0)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_0 = Path();
//     path_0.moveTo(size.width * 1.0278545, size.height * 1.0043300);
//     path_0.lineTo(size.width * -0.0254545, size.height * 1.0060000);
//     path_0.lineTo(size.width * 0.0000182, size.height * 0.5796600);
//     path_0.quadraticBezierTo(
//       size.width * 0.0100000,
//       size.height * 0.5090000,
//       size.width * 0.1272727,
//       size.height * 0.4930000,
//     );
//     path_0.cubicTo(
//       size.width * 0.9145455,
//       size.height * 0.4945500,
//       size.width * 0.9037818,
//       size.height * 0.5228800,
//       size.width * 0.9895091,
//       size.height * 0.3955200,
//     );
//     path_0.quadraticBezierTo(
//       size.width * 1.1464364,
//       size.height * 0.5279900,
//       size.width * 1.0278545,
//       size.height * 1.0043300,
//     );
//     path_0.close();

//     canvas.drawPath(path_0, paint_fill_0);

//     // Layer 1

//     Paint paint_stroke_0 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     canvas.drawPath(path_0, paint_stroke_0);

//     // Layer 1

//     Paint paint_fill_1 = Paint()
//       ..color = const Color.fromARGB(255, 255, 255, 255)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_1 = Path();
//     path_1.moveTo(size.width * 0.8981818, size.height * 0.4340000);

//     canvas.drawPath(path_1, paint_fill_1);

//     // Layer 1

//     Paint paint_stroke_1 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     canvas.drawPath(path_1, paint_stroke_1);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
