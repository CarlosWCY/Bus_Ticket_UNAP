import 'package:bt_unap/views/trips/trip_ticket_page.dart';
import 'package:bt_unap/utilities/consts.dart';
import 'package:flutter/material.dart';

class TripsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TripTicketPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(26),
                    margin: EdgeInsets.fromLTRB(26, 26, 26, 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 4,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/companies_logo/gol_logo.png',
                              ),
                            ),
                            SizedBox(height: 28),
                            Text(
                              'Viaje 122 ',
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                            SizedBox(height: 28),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Origen',
                                      style: TextStyle(color: veppoLightGrey),
                                    ),
                                    Text('Puno'),
                                    SizedBox(height: 28),
                                    Text(
                                      'Destino',
                                      style: TextStyle(color: veppoLightGrey),
                                    ),
                                    Text('Juliaca'),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Salida',
                                      style: TextStyle(color: veppoLightGrey),
                                    ),
                                    Text('6:30 pm'),
                                    SizedBox(height: 28),
                                    Text(
                                      'Llegada',
                                      style: TextStyle(color: veppoLightGrey),
                                    ),
                                    Text('7:30 pm'),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
