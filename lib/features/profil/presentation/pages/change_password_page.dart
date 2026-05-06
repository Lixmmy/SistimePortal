import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsistime/core/localization/localization_service.dart';
import 'package:newsistime/custom_widgets/appbarcustom.dart';
import 'package:newsistime/features/profil/presentation/bloc/profil_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isObsecure = true;
  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: appL10n.changePassword,
        isShowBackButton: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: BlocListener<ProfilBloc, ProfilState>(
        listener: (context, state) {
          if (state is ProfilSuccessUpdate) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              title: 'Success',
              text: state.message,
            ).then((_) {
              // ignore: use_build_context_synchronously
              context.pop();
            });
          } else if (state is ProfilError) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Error',
              text: state.message,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      _isObsecure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObsecure = !_isObsecure;
                      });
                    },
                  ),
                ),
                onSubmitted: (value) {
                  context.read<ProfilBloc>().add(
                    ProfilChangePassword(newPassword: _passwordController.text),
                  );
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<ProfilBloc>().add(
                      ProfilChangePassword(
                        newPassword: _passwordController.text,
                      ),
                    );
                  },
                  child: Text("Ganti"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
