import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kyc_app/bank_kyc_screen.dart';
import 'package:kyc_app/providers/user_provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'models/user_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String name = '';

  Future<String?> fetchUserData() async {
    try {
      UserModel? userData = UserProvider().userModel;
      if (userData != null) {
        Logger().i(userData);
        if (mounted) {
          setState(() {
            name = userData.name;
          });
        }
      }
    } catch (e) {
      // Handle error if necessary
      Logger().e(e);
      return null;
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String currentDate = '${DateTime.now().day.toString().padLeft(2, "0")}-${DateTime.now().month.toString().padLeft(2, "0")}-${DateTime.now().year}';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.indigo.shade500,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Text(
                    currentDate,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Expanded(child: IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))),
                Expanded(
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.red,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset('assets/images/avatar.jpg'),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Row(
              children: [
                Text(
                  'Hi, Guest',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                // Consumer<UserProvider>(
                //   builder: (BuildContext context, UserProvider userProvider, Widget? child) {
                //     UserModel? userModel = userProvider.userModel;
                //     return Text(
                //       'Hi, ${userModel?.name ?? 'Guest'}',
                //       style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                //     );
                //   },
                // ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Logger().i(message),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BankKycScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: screenWidth * .45,
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.add_rounded,
                          size: screenHeight * 0.1,
                          color: Colors.redAccent.shade200,
                        ),
                        Text(
                          'Onboard Agent',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.redAccent.shade200,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * .45,
                  height: screenHeight * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.person_rounded,
                        size: screenHeight * 0.125,
                        color: Colors.green.shade300,
                      ),
                      Text(
                        'View Agent',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.green.shade300,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: screenWidth,
            child: const Text(
              'Onboarding data',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                itemCount: 4,
                itemBuilder: (context, index) => Container(
                  width: screenWidth * .45,
                  height: screenHeight * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.person_rounded,
                        size: screenHeight * 0.125,
                        color: Colors.green.shade200,
                      ),
                      Text(
                        'View Agent',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.green.shade200,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
