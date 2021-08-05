import 'package:appnation_spacex/api/api_call.dart';
import 'package:appnation_spacex/model/spacex_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final ApiCall apiCall = ApiCall();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "SpaceX Last Mission",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<SpaceX>(
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
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("ID"),
                            trailing: Text(snapshot.data!.id.toString()),
                          ),
                          ListTile(
                            title: Text("Spaceship Name"),
                            trailing: Text(snapshot.data!.name.toString()),
                          ),
                          ListTile(
                              title: Text("Flight Number"),
                              trailing:
                                  Text(snapshot.data!.flightNumber.toString())),
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
                            child: ListTile(
                                title: Text("Patch"),
                                trailing: Image.network(snapshot
                                    .data!.links!.patch!.small
                                    .toString())),
                          ),
                          ListTile(
                            title: Text("Date"),
                            trailing: Text(
                              DateFormat('yyyy/MM/dd' + '\t\t' + 'HH:mm')
                                  .format(snapshot.data!.dateUtc!),
                            ),
                          ),
                          ListTile(
                            title: Text("Status"),
                            trailing: Text(
                              snapshot.data!.success! ? "Success" : "Failed",
                            ),
                          ),
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
      ),
    );
  }
}
