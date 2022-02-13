import 'package:ezcountry/common/constants.dart';
import 'package:ezcountry/common/dimensions.dart';
import 'package:ezcountry/providers/homepage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  final Function filterList;

  const CustomAppBar({Key key, this.filterList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Dimensions.dimension_15,
          left: Dimensions.dimension_15,
          right: Dimensions.dimension_10,
          bottom: Dimensions.dimension_5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              Constants.appName,
              style: TextStyle(
                  fontSize: Dimensions.dimension_25,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Stack(
            children: [
              IconButton(
                  onPressed: filterList ?? () {},
                  icon: Image.asset(Constants.filterImagePath,
                      width: Dimensions.dimension_25)),
              Consumer<HomepageProvider>(
                builder: (context, model, child) =>
                    model.selectedLanguage.isNotEmpty
                        ? Positioned(
                            top: Dimensions.dimension_5,
                            right: Dimensions.dimension_5,
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                              width: Dimensions.dimension_8,
                              height: Dimensions.dimension_8,
                            ),
                          )
                        : const SizedBox.shrink(),
              )
            ],
          )
        ],
      ),
    );
  }
}
