import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// ignore: depend_on_referenced_packages
import 'package:newsistime/custom_widgets/container_view.dart';


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Center(
              child: ContainerView(
                width: 200,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/logo_stmik.png', height: 80),
                    const Text(
                      'STMIK TIME',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 95, 189, 252),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const SpinKitThreeBounce(
                      // Animasi loading
                      color: Color.fromARGB(255, 95, 189, 252),
                      size: 30.0,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Please wait...',
                      style: TextStyle(
                        color: Color.fromARGB(255, 95, 189, 252),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
