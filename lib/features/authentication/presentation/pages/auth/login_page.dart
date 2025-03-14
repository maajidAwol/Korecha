import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/constants.dart';
import 'package:shop/route/route_constants.dart';

import 'package:shop/features/authentication/presentation/state/auth/bloc/auth_bloc.dart';
import 'package:shop/features/authentication/presentation/widgets/auth/login_form.dart';
import 'package:shop/features/authentication/presentation/pages/auth/email_verification_page.dart';
import 'package:shop/core/services/storage_service.dart';
import 'package:get_it/get_it.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  void _loadSavedCredentials() {
    final storageService = GetIt.I<StorageService>();
    final savedEmail = storageService.getUserEmail();
    final savedPassword = storageService.getUserPassword();
    
    if (savedEmail != null) {
      _emailController.text = savedEmail;
    }
    if (savedPassword != null) {
      _passwordController.text = savedPassword;
    }
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
      
      // Save credentials when login is attempted
      GetIt.I<StorageService>().saveUserCredentials(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthVerificationRequired) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmailVerificationPage(
                  email: state.email,
                ),
              ),
            );
          } else if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              entryPointScreenRoute,
              ModalRoute.withName(logInScreenRoute),
            );
          } else if (state is AuthError) {
            // print(state.message); 
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is LogoutSuccess) {
           
            _emailController.clear();
            _passwordController.clear();
            // GetIt.I<StorageService>().clearUserCredentials();
          }
        },
        builder: (context, state) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                    child: SizedBox(
                      width: width * 0.6,
                      height: height * 0.16,
                      child: Image.asset("assets/koricha/logo-full.png"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome back to Korecha!",
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: defaultPadding / 2),
                        const Text(
                          "Log in with your data that you entered during \n your registration.",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: defaultPadding),
                        LogInForm(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                        ),
                        Align(
                          child: TextButton(
                            child: const Text("Forgot password"),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, passwordRecoveryScreenRoute);
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height > 700
                              ? MediaQuery.of(context).size.height * 0.1
                              : defaultPadding,
                        ),
                        ElevatedButton(
                          onPressed: _handleLogin,
                          child: state is AuthLoading
                              ? const CircularProgressIndicator()
                              : const Text("Log in"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, signUpScreenRoute);
                              },
                              child: const Text("Sign up"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
