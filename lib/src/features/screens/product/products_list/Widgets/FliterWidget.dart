import 'package:flutter/material.dart';
import 'package:flutter_noel/src/constants/colors.dart';
import 'package:flutter_noel/src/features/controllers/product/products_list/products_list_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
    required ProductsListController controller,
  }) : _controller = controller;

  final ProductsListController _controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 100,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          AppLocalizations.of(context)!.filteredBy,
                          style: Theme.of(context).textTheme.headlineMedium
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {_controller.displayFilteredProduct("");},
                              child: Text((AppLocalizations.of(context)!.all))
                          ),
                          ElevatedButton(
                              onPressed: () {_controller.displayFilteredProduct("hat");},
                              child: Text((AppLocalizations.of(context)!.hat))
                          ),
                          ElevatedButton(
                              onPressed: () {_controller.displayFilteredProduct("glove");},
                              child: Text((AppLocalizations.of(context)!.gloves))
                          ),
                          ElevatedButton(
                              onPressed: () {_controller.displayFilteredProduct("sweater");},
                              child: Text((AppLocalizations.of(context)!.sweater))
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
        );
      },
      backgroundColor: primaryColor,
      child: const Icon(Icons.filter_alt_sharp, color: lightColor,),
    );
  }
}