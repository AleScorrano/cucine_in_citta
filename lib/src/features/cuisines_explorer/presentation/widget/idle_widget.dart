import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IdleWidget extends StatelessWidget {
  const IdleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: SvgPicture.asset("assets/images/italy.svg", width: 200)),
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
    );
  }
}
