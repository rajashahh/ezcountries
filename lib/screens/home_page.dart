import 'package:ezcountry/common/constants.dart';
import 'package:ezcountry/common/dimensions.dart';
import 'package:ezcountry/providers/homepage_provider.dart';
import 'package:ezcountry/screens/widgets/country_item.dart';
import 'package:ezcountry/screens/widgets/custom_app_bar.dart';
import 'package:ezcountry/screens/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:ezcountry/model/country.dart';
import 'package:ezcountry/common/colors.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    initViews();
    super.initState();
  }

  Future<void> initViews() async {
    await Future.delayed(Duration.zero);
    Provider.of<HomepageProvider>(context, listen: false).fetchCountries();
  }

  Widget countriesListView({List<Country> countriesList}) {
    return Expanded(
      child: countriesList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Constants.pageNotFoundImagePath,
                    width: Dimensions.dimension_80,
                  ),
                  const SizedBox(
                    height: Dimensions.dimension_10,
                  ),
                  Text(
                    Constants.noCountryFound,
                    style: const TextStyle(
                        fontSize: Dimensions.dimension_15,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: countriesList.length,
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.dimension_10),
              itemBuilder: (context, position) => CountryItem(
                country: countriesList[position],
              ),
            ),
    );
  }

  Widget languagesList() => Consumer<HomepageProvider>(
        builder: (context, model, child) => ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: model.languageList.length,
          itemBuilder: (context, position) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(model.languageList[position])),
                  Checkbox(
                      value: model.selectedLanguage
                          .contains(model.languageList[position]),
                      onChanged: (value) {
                        model.updateLanguageSettings(
                            value: value,
                            language: model.languageList[position]);
                      }),
                ],
              )
            ],
          ),
        ),
      );

  void filterList() {
    showModalBottomSheet<void>(
      isScrollControlled: false,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      context: context,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.dimension_15),
            topRight: Radius.circular(Dimensions.dimension_15)),
      ),
      builder: (BuildContext context) {
        return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(Dimensions.dimension_10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: Dimensions.dimension_10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(Constants.filterImagePath,
                              width: Dimensions.dimension_20),
                          const SizedBox(
                            width: Dimensions.dimension_10,
                          ),
                          Text(
                            Constants.filterByLanguage,
                            style: const TextStyle(
                                fontSize: Dimensions.dimension_17,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const SizedBox(
                            child: Text("X",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: Dimensions.dimension_15)),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.dimension_10,
                  ),
                  Divider(
                    color: dividerColor,
                  ),
                  Expanded(child: languagesList()),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<HomepageProvider>(context,
                                    listen: false)
                                .removeFilter();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.all(Dimensions.dimension_10),
                            color: Colors.red,
                            child: Text(
                              Constants.removeFilter,
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomepageProvider>(
          builder: (context, model, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                filterList: filterList,
              ),
              Divider(
                color: dividerColor,
              ),
              const SearchBar(),
              model.isLoading
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : countriesListView(countriesList: model.countriesList),
            ],
          ),
        ),
      ),
    );
  }
}
