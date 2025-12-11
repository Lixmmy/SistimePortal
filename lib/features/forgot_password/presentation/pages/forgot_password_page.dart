import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/theme/theme.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            forceMaterialTransparency: true,
            automaticallyImplyLeading: true,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              onPressed: () {
                context.pop();
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('images/logo_stmik.png', width: 40, height: 40),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: SizedBox(width: 8),
                      ), // Spacing between logo and text
                      TextSpan(
                        text: 'STMIK',
                        style: Theme.of(context).appBarTheme.titleTextStyle
                            ?.copyWith(
                              fontWeight: FontWeight.w200,
                              color: AppTheme.primaryColorA0,
                            ),
                      ),
                      TextSpan(
                        text: ' TIME',
                        style: Theme.of(context).appBarTheme.titleTextStyle
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.brightnessOf(context) == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Image.asset(
                  'images/walpaper_login.png',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                    color: Theme.brightnessOf(context) == Brightness.dark
                        ? AppTheme.surfaceDarkColorA0.withAlpha(128)
                        : Colors.white.withAlpha(128),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsGeometry.only(
                    top: 50,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Forgot Password',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "if you've forgotten your password, please enter your email address to reset your password.",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Email",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      TextField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Email',
                        ),
                        onSubmitted: (value) {},
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Forgot Password'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
