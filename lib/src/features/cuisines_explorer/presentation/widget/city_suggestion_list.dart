import 'package:cucine_in_citta/src/core/theme/app_colors.dart';
import 'package:cucine_in_citta/src/core/theme/app_dimensions.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/data/models/city_model.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/cubit/cuisines_explorer_cubit.dart';
import 'package:cucine_in_citta/src/features/cuisines_explorer/presentation/widget/city_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CitySuggestionListUseCase { showSuggestion, showRecentSearch }

class CitySuggestionList extends StatefulWidget {
  final CitySuggestionListUseCase useCase;
  final List<CityModel> cities;

  const CitySuggestionList({
    super.key,
    required this.useCase,
    required this.cities,
  });

  @override
  State<CitySuggestionList> createState() => _CitySuggestionListState();
}

class _CitySuggestionListState extends State<CitySuggestionList> {
  final _listKey = GlobalKey<AnimatedListState>();

  late final List<CityModel> _cities = List.of(widget.cities);

  Future<void> _removeCity(CityModel city, int index) async {
    final cubit = context.read<CuisineExplorerCubit>();

    _cities.removeAt(index);

    _listKey.currentState?.removeItem(
      index,
      duration: const Duration(milliseconds: 200),
      (context, animation) {
        return SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(1, 0),
            ).chain(CurveTween(curve: Curves.easeOut)),
          ),
          child: Material(
            color: AppColors.surface,
            child: Column(
              children: [
                CityTile(city: city, onTap: () {}, onDelete: null),
                const Divider(height: 1, color: AppColors.border),
              ],
            ),
          ),
        );
      },
    );

    await cubit.deleteRecentCity(city);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CuisineExplorerCubit>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: AnimatedList(
        physics: widget.useCase == CitySuggestionListUseCase.showRecentSearch
            ? NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(),
        key: _listKey,
        shrinkWrap: true,
        initialItemCount: _cities.length,
        itemBuilder: (context, index, animation) {
          final city = _cities[index];

          return ClipRRect(
            child: SizeTransition(
              sizeFactor: animation,
              child: Column(
                children: [
                  CityTile(
                    city: city,
                    onTap: () {
                      cubit.selectCity(city);
                    },
                    onDelete:
                        widget.useCase ==
                            CitySuggestionListUseCase.showRecentSearch
                        ? () => _removeCity(city, index)
                        : null,
                  ),
                  if (index != _cities.length - 1)
                    const Divider(height: 1, color: AppColors.border),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
