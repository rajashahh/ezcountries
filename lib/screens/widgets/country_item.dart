import 'package:ezcountry/common/constants.dart';
import 'package:ezcountry/common/dimensions.dart';
import 'package:ezcountry/model/country.dart';
import 'package:ezcountry/common/colors.dart';
import 'package:flutter/material.dart';

class CountryItem extends StatelessWidget {
  final Country country;

  const CountryItem({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Constants.countryDetailsPath, arguments: country);
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.83,
            margin: const EdgeInsets.only(
                bottom: Dimensions.dimension_10, top: Dimensions.dimension_20),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.dimension_15,
                vertical: Dimensions.dimension_20),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(
                        Dimensions.dimension_0, Dimensions.dimension_5),
                    color: kShadowColor,
                    blurRadius: Dimensions.dimension_10,
                  ),
                ],
                borderRadius: BorderRadius.circular(Dimensions.dimension_10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    country.name,
                    style: const TextStyle(
                        fontSize: Dimensions.dimension_17,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  width: Dimensions.dimension_80,
                )
              ],
            ),
          ),
          Positioned(
            right: Dimensions.dimension_15,
            child: Row(
              children: [
                Container(
                  height: Dimensions.dimension_50,
                  width: Dimensions.dimension_1,
                  color: dividerColor,
                  margin: const EdgeInsets.only(top: Dimensions.dimension_10),
                ),
                Text(
                  country.emoji,
                  style: const TextStyle(
                    fontSize: Dimensions.dimension_50,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
