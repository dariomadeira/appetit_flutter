import 'package:flutter/material.dart';
import 'package:appetit/src/widgets/states/loading_widget.dart';

class PreloadWidget extends StatelessWidget {

  final List<Future<dynamic>>? loadingFutures;
  final Widget? child;
  final Color? backgroundColor;

  const PreloadWidget({
    required this.loadingFutures,
    required this.child,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(this.loadingFutures!),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) { 
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Center(
              child: LoadingWidget(),
            ),
          );
        }
        return child!;
      },
    );
  }
}