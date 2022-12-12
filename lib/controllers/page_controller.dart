import 'package:bt_unap/constants/routes.dart';
import 'package:bt_unap/views/messages/messages_page.dart';
import 'package:bt_unap/views/search/search_page.dart';
import 'package:bt_unap/views/trips/trips_page.dart';
import 'package:bt_unap/utilities/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum MenuAction { logout }

class PagesController extends StatefulWidget {
  @override
  _PagesControllerState createState() => _PagesControllerState();
}

class _PagesControllerState extends State<PagesController> {
  PageController _pageController = PageController(initialPage: 0);
  int bottomNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Menú Principal'),
        actions: [
          PopupMenuButton(
            onSelected: (value) async{
              switch(value){
                
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut){
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute, 
                      (_) => false,
                    );
                  }
              }
            }, 
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Salir'),
                ),
              ];
            },
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [
          SearchPage(),
          TripsPage(),
          MessagePage(),
          Container(
            child: Center(
              child: Text('Perfiles'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
            )
          ],
        ),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: veppoBlue,
          unselectedItemColor: veppoLightGrey,
          currentIndex: bottomNavigationIndex,
          onTap: (index) {
            setState(() {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 400),
                curve: Curves.decelerate,
              );
              bottomNavigationIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'Buscar',
              icon: Icon(Icons.search_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Viajes',
              icon: Icon(Icons.menu),
            ),
            BottomNavigationBarItem(
              label: 'Mensajes',
              icon: Icon(Icons.chat_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Perfiles',
              icon: Icon(Icons.supervised_user_circle_sharp),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context){
  return showDialog<bool>(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text('Salir de la cuenta'),
        content: const Text('¿Estás seguro que quieres salir?'),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop(false);
          }, 
          child: const Text('Cancelar')
          ),
          TextButton(onPressed: () {
            Navigator.of(context).pop(true);
          }, 
          child: const Text('Salir')
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}