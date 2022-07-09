import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/profile_view_model.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({Key? key}) : super(key: key);
  ProfileViewModel profileViewModel = ProfileViewModel();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ref.watch(profileViewModel.profileDataProvider).when(
              data: (user) {
                String imagePath =
                    user.gender == "male" ? "male.jpg" : "female.png";
                print("Profile User :$user");
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      CircleAvatar(
                        radius: 65,
                        child: Image.asset(
                          "assets/$imagePath",
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        user.name!,
                        style: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.blueGrey,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Chip(
                            label: Text(
                              "@${user.username}",
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black45,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Chip(
                            label: Text(
                              user.phone.toString(),
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black45,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              },
              error: (e, s) {
                return const Text("Error");
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
      ),
    );
  }
}
