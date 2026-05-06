import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/loading/loading_manage.dart';
import 'package:newsistime/core/localization/localization_service.dart';
import 'package:newsistime/core/route_config/config.dart';
import 'package:newsistime/core/route_config/route_endpoint.dart';
import 'package:newsistime/core/theme/theme.dart';
import 'package:quickalert/quickalert.dart';
import 'package:newsistime/features/login/presentation/bloc/login_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObsecure = true;
  bool _canAuthenticate = false;
  bool _hasEnrolledBiometrics = false;
  bool _isHaveCredentials = false;

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(CheckBiometricSupport());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading ||
                  state is LoginBiometricAuthenticating) {
                LoadingManager().show(context);
              } else {
                if (LoadingManager().isShowing) {
                  LoadingManager().dismiss();
                }
              }

              if (state is LoginFailure) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: appL10n.error,
                  text: state.message,
                );
              }
              if (state is LoginBiometricFailure) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: appL10n.biometricError,
                  text: state.message,
                );
              }
              if (state is LoginSuccess || state is LoginBiometricSuccess) {
                context.goNamed('selectedPage');
              }
              if (state is LoginBiometricSupportChecked) {
                setState(() {
                  _canAuthenticate = state.canAuthenticate;
                  _hasEnrolledBiometrics = state.hasEnrolledBiometrics;
                  _isHaveCredentials = state.isHaveCredentials;
                });
              }
            },
            builder: (context, state) {
              return SliverToBoxAdapter(
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
                      padding: const EdgeInsets.only(
                        top: 50,
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appL10n.login,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            appL10n.enterYourUsernameAndPasswordToLogin,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            appL10n.username,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextField(
                            controller: _usernameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            maxLength: 7,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Username',
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            appL10n.password,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextField(
                            controller: _passwordController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _isObsecure,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObsecure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObsecure = !_isObsecure;
                                  });
                                },
                              ),
                            ),
                            onSubmitted: (value) {
                              context.read<LoginBloc>().add(
                                LoginEventPostLogin(
                                  username: _usernameController.text,
                                  password: _passwordController.text,
                                ),
                              );
                            },
                          ),
                          TextButton(
                            onPressed: () async {
                              await launchUrl(
                                Uri(
                                  scheme: scheme,
                                  host: host,
                                  path: forgotPasswordRoute,
                                ),
                                mode: LaunchMode.inAppWebView,
                              );
                            },
                            child: Text(appL10n.forgotPassword),
                          ),
                          if (_canAuthenticate &&
                              _hasEnrolledBiometrics &&
                              _isHaveCredentials)
                            Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.fingerprint,
                                  size: 60,
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                    AuthenticateWithBiometrics(),
                                  );
                                },
                              ),
                            ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<LoginBloc>().add(
                                  LoginEventPostLogin(
                                    username: _usernameController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              },
                              child: Text(appL10n.login),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
