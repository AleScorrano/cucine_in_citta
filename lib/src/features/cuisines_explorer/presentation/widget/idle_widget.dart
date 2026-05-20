import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IdleWidget extends StatelessWidget {
  const IdleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageSize = (constraints.maxHeight * 0.50).clamp(140.0, 260.0);

        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(end: imageSize),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  builder: (context, size, child) {
                    return SizedBox(width: size, child: child);
                  },
                  child: SvgPicture.asset("assets/images/italy.svg"),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.xxl),
                  child: Text(
                    "Inizia a cercare una città per scoprire le cucine disponibili",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
