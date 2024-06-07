import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class CourseView extends StatelessWidget {
  const CourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Center(
        child: Text('Course'),
      ),
    );
  }
}