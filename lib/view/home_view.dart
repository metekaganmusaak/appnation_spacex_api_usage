import 'package:appnation_spacex/api/api_call.dart';
import 'package:appnation_spacex/controllers/network_controller.dart';
import 'package:appnation_spacex/model/spacex_model.dart';
import 'package:appnation_spacex/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  final NetworkController _networkController = Get.put(NetworkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "SpaceX Latest Mission",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(() {
        if (_networkController.hasConnection.value == false) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.signal_wifi_statusbar_connected_no_internet_4,
                    size: 56),
                Text(
                  "No Internet Connection\nPlease Check Your Internet",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          final ApiCall apiCall = ApiCall();
          return FutureBuilder<SpaceX>(
            future: apiCall.apiCall(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // if fetching operations success, this state will work
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.hasData);
                return Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Info",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24),
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          child: Column(
                            children: [
                              CustomListTile(
                                  title: "ID",
                                  trailing: "${snapshot.data!.id.toString()}"),
                              CustomListTile(
                                title: "Spaceship Name",
                                trailing: "${snapshot.data!.name.toString()}",
                              ),
                              CustomListTile(
                                  title: "Flight Number",
                                  trailing:
                                      "${snapshot.data!.flightNumber.toString()}"),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Image.network(snapshot
                                              .data!.links!.patch!.small
                                              .toString()),
                                        );
                                      });
                                },
                                child: CustomListTile(
                                  title: "Patch",
                                  trailing:
                                      "${snapshot.data!.links!.patch!.small.toString()}",
                                  isImage: true,
                                ),
                              ),
                              CustomListTile(
                                  title: "Date",
                                  trailing: DateFormat(
                                          'yyyy/MM/dd' + '\t\t' + 'HH:mm')
                                      .format(snapshot.data!.dateUtc!)),
                              CustomListTile(
                                  title: "Status",
                                  trailing: "${snapshot.data!.success!}"
                                              .toLowerCase() ==
                                          "true"
                                      ? "Success"
                                      : "Failed"),
                              ExpansionTile(
                                title: Text("Details"),
                                iconColor: Colors.black,
                                childrenPadding: EdgeInsets.only(
                                    top: 0, left: 14, right: 14, bottom: 10),
                                backgroundColor: Colors.grey[100],
                                initiallyExpanded: true,
                                children: [
                                  Text(snapshot.data!.details.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                // If there is an error with the api fetching operation this state will work.
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueGrey,
                  ),
                );
              }
            },
          );
        }
      }),
    );
  }
}
