import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IdleWidget extends StatelessWidget {
  const IdleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SvgPicture.asset("assets/images/idle.svg", width: 350),
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
    );
  }
}
