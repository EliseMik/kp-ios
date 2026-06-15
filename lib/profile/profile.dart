import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/services/services.dart';
import 'package:quizapp/shared/shared.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text("Профиль ${user.displayName!}"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(top: 50),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/user.png'
                    ),
                  ),
                ),
              ),
              Text(user.email ?? 'Гость',
                  style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              Text('${report.total}',
                  style: Theme.of(context).textTheme.displayMedium),
              Text('Выполнено тестов',
                  style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              ElevatedButton(
                child: const Text('Выйти'),
                onPressed: () async {
                  await AuthService().signOut();
                  if (mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
      );
    } else {
      return const Loader();
    }
  }
}
