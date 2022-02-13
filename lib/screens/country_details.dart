import 'package:ezcountry/common/colors.dart';
import 'package:ezcountry/common/constants.dart';
import 'package:ezcountry/common/dimensions.dart';
import 'package:ezcountry/model/country.dart';
import 'package:ezcountry/providers/homepage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryDetails extends StatefulWidget {
  const CountryDetails({Key key}) : super(key: key);

  @override
  _CountryDetailsState createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  Country country;

  @override
  void initState() {
    initViews();
    super.initState();
  }

  void initViews() async {
    await Future.delayed(Duration.zero);
    country = ModalRoute.of(context).settings.arguments as Country;
    Provider.of<HomepageProvider>(context, listen: false)
        .fetchCountryDetails(code: country.code);
  }

  Widget appBar() => Padding(
        padding: const EdgeInsets.only(
            top: Dimensions.dimension_15,
            left: Dimensions.dimension_15,
            right: Dimensions.dimension_10,
            bottom: Dimensions.dimension_5),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (Navigator.canPop(context)) Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: Dimensions.dimension_15),
                child: Image.asset(
                  Constants.returnImagePath,
                  width: Dimensions.dimension_20,
                ),
              ),
            ),
            Expanded(
              child: Text(
                Constants.countryDetails,
                style: const TextStyle(
                    fontSize: Dimensions.dimension_20,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      );

  Widget countryDetails({Country selectedCountry}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.dimension_20),
      child: Column(
        children: [
          const SizedBox(
            height: Dimensions.dimension_30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedCountry.name,
                style: const TextStyle(
                    fontSize: Dimensions.dimension_17,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                selectedCountry.emoji,
                style: const TextStyle(
                  fontSize: Dimensions.dimension_50,
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: Dimensions.dimension_10),
            child: Divider(
              height: Dimensions.dimension_1,
              color: dividerColor,
            ),
          ),
          rowDetails(title: Constants.phonePrefix, value: "+" + selectedCountry.phone),
          rowDetails(title: Constants.currency, value: selectedCountry.currency),
          rowDetails(title: Constants.countryCode, value: selectedCountry.code),
          rowDetails(title: Constants.continent, value: selectedCountry.continent.name),
        ],
      ),
    );
  }

  Widget rowDetails({String title, String value}) => Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.dimension_10,
            horizontal: Dimensions.dimension_5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title + ":",
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.dimension_16),
            ),
            Text(
              value==null || value.isEmpty?"-":value,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.dimension_16),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<HomepageProvider>(
          builder: (context, model, child) => model.isDetailsLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : model.selectedCountry == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(Constants.noDataFoundImagePath,width: Dimensions.dimension_50,),
                          const SizedBox(height: Dimensions.dimension_10,),
                          Text(
                            Constants.noDataFound,
                            style: const TextStyle(
                                fontSize: Dimensions.dimension_15,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appBar(),
                          countryDetails(selectedCountry:model.selectedCountry),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
