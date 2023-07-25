import 'dart:developer';

import 'package:fictive_box_task/providers/location_details_provider.dart';
import 'package:fictive_box_task/providers/user_details_provider.dart';
import 'package:fictive_box_task/utils/string_utils.dart';
import 'package:fictive_box_task/views/widgets/button_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(StringUtils.appName),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final ref = Provider.of<UserDetailsProvider>(context, listen: false);
      ref.getUserDetails(context);
    });
  }

  // User Details
  userDetailsWidget() {
    return Consumer<UserDetailsProvider>(builder: (context, udPro, _) {
      if (udPro.loading) {
        return const Center(child: CircularProgressIndicator());
      } else {
        ViewDetailDatum data = udPro.userDetails!.response.viewDetailData.first;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${StringUtils.orderId}#${data.orderId}",
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    data.poojaTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Text(
                  "${StringUtils.poojaDuration}${data.pujaDuration}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${StringUtils.poojaLang}${data.pujaLanguage}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${StringUtils.poojaMode}${data.pujaMode}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${StringUtils.name}${data.name}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${StringUtils.email}${data.email}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  "${StringUtils.phone}${data.phone}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Flexible(
                        child: Text(
                          data.address,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  showDirectionButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<UserDetailsProvider>(builder: (context, userDetailsRef, _) {
            if (userDetailsRef.loading) {
              return const SizedBox.shrink();
            } else {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(130.0, 48.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                  onPressed: () {
                    final userRef = Provider.of<UserDetailsProvider>(context,
                        listen: false);
                    final locationRef = Provider.of<LocationDetailsProvider>(
                        context,
                        listen: false);
                    userRef.goToRouteScreen(context,
                        source: locationRef.source,
                        destination: locationRef.destination);
                  },
                  child: Text(StringUtils.showDirection.toUpperCase()));
            }
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: userDetailsWidget(),
      bottomNavigationBar: showDirectionButton(),
    );
  }
}
