import 'package:ezcountry/common/constants.dart';
import 'package:ezcountry/common/dimensions.dart';
import 'package:ezcountry/providers/homepage_provider.dart';
import 'package:flutter/material.dart';
import 'package:ezcountry/common/colors.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchController;

  @override
  void initState() {
    initViews();
    super.initState();
  }

  void initViews() async {
    await Future.delayed(Duration.zero);
    _searchController = TextEditingController();
    _searchController.addListener(() {
      if(_searchController.text.trim().isEmpty) {
        Provider.of<HomepageProvider>(context, listen: false)
            .reInitializeCountries();
      }
    });
    setState(() {

    });
  }

  void searchCountry() {
    Provider.of<HomepageProvider>(context, listen: false)
        .searchByCountryCode(value: _searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(
        Dimensions.dimension_15,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset:
                  const Offset(Dimensions.dimension_0, Dimensions.dimension_5),
              color: kShadowColor,
              blurRadius: Dimensions.dimension_10,
            ),
          ],
          borderRadius: BorderRadius.circular(Dimensions.dimension_10)),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _searchController,
              cursorColor: Colors.black,
              maxLines: 1,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(Dimensions.dimension_15),
                hintText: Constants.searchByCountryCode,
                hintStyle: TextStyle(
                  color: searchIconColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
          IconButton(
              onPressed: searchCountry,
              icon: Image.asset(
                Constants.searchImagePath,
                width: Dimensions.dimension_25,
              )),
        ],
      ),
    );
  }
}
