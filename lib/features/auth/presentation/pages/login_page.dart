import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/widgets/app_logo.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../internationalization/generated/translations.dart';
import '../../domain/validators/auth_validators.dart';
import '../state/auth_bloc.dart';
import '../state/auth_event.dart';
import '../state/auth_state.dart';
import '../utils/auth_error_handler.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_error_banner.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/blue_text_button.dart';
import '../widgets/register_row.dart';
import '../widgets/signin_with_button.dart';
import '../widgets/social_divider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    this.errorMessage,
  });

  final String? errorMessage;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequestedEvent(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = Translations.of(context);
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              
              AppLogo(size: 80),
              
              const SizedBox(height: 24),
              
              Text(
                translations.signInToContinue,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              
              Text(
                translations.signInToContinue,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              
              const SizedBox(height: 24),
              
              if (widget.errorMessage != null) ...[
                AuthErrorBanner(message: widget.errorMessage!),
                const SizedBox(height: 24),
              ],
              
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AuthTextField(
                      controller: _emailController,
                      label: translations.email,
                      hintText: translations.email,
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        try {
                          AuthValidators.validateEmail(value!);
                          return null;
                        } catch (e) {
                          return AuthErrorHandler.getErrorMessage(e, context);
                        }
                      },
                    ),
                    
                    const SizedBox(height: 12),

                    AuthTextField(
                      controller: _passwordController,
                      label: translations.password,
                      hintText: translations.password,
                      prefixIcon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      validator: (value) {
                        try {
                          AuthValidators.validatePassword(value!);
                          return null;
                        } catch (e) {
                          return AuthErrorHandler.getErrorMessage(e, context);
                        }
                      },
                    ),
                    
                    Align(
                      alignment: Alignment.centerRight,
                      child: BlueTextButton(
                        label: translations.forgotPassword,
                        onPressed: () {
                          // TODO: Implementar forgot password
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Login button
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return AuthButton(
                          text: translations.signIn,
                          isLoading: state is AuthLoadingState,
                          onPressed: _submitLogin,
                        );
                      },
                    ),
                    
                    const SizedBox(height: 24),

                    SocialDivider(),

                    const SizedBox(height: 24),

                    SignInWithButton(
                      label: translations.signInWithGoogle,
                      logo: 'assets/google_logo.png',
                      onPressed: () {
                        // TODO: Navegar a registro con google
                      },
                    ),

                    const SizedBox(height: 12),
                    
                    RegisterRow(
                      prompt: translations.dontHaveAccount,
                      actionLabel: translations.signUp,
                      onPressed: () {
                        // TODO: Navegar a registro
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}