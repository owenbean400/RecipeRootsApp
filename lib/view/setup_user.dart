import 'package:flutter/material.dart';
import 'package:recipe_roots/domain/person.dart';
import 'package:recipe_roots/service/person_service.dart';
import 'package:recipe_roots/view/navigation_view.dart';
import 'package:recipe_roots/view/window/user_add_view.dart';

class SetupUserView extends StatefulWidget {
  const SetupUserView({super.key});

  @override
  SetupUserViewState createState() => SetupUserViewState();
}

class SetupUserViewState extends State<SetupUserView> {
  Future<bool> userSetup = PersonService().userSetup();

  void setPeopleNavViewFunction(Person user) async {
    await PersonService().setUser(user);
    setState(() {
      userSetup = PersonService().userSetup();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userSetup,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!) {
              return const NavigationViewBar();
            } else {
              return Scaffold(
                  body: UserAddView(addUser: setPeopleNavViewFunction));
            }
          }

          return Scaffold(body: Container());
        }));
  }
}
