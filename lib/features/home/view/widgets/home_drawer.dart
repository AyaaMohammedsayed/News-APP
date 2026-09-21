import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/core/Theme/app_theme.dart';
import 'package:news/core/constants/app_images.dart';
import 'package:news/core/provider/settings.dart';
import 'package:news/features/Auth/view/login_screen.dart';
import 'package:news/features/Auth/view_model/auth_cubit.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  final VoidCallback resetModel;

  const HomeDrawer({super.key, required this.resetModel});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    var provider = Provider.of<SettingServicesProvider>(context);

    return Container(
      width: MediaQuery.sizeOf(context).width * 0.7,
      color: AppTheme.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.sizeOf(context).height * 0.25,
            decoration: BoxDecoration(color: AppTheme.white),
            child: Text(
              'News App',
              textAlign: TextAlign.center,
              style: textTheme.headlineSmall!.copyWith(
                color: AppTheme.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      resetModel();
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.home),
                        const SizedBox(width: 12),
                        Text(
                          'Go To Home',
                          style: textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 32, color: Colors.grey),

                  Row(
                    children: [
                      SvgPicture.asset(AppImages.theme),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButton<ThemeMode>(
                          dropdownColor: AppTheme.black,
                          borderRadius: BorderRadius.circular(15),
                          isExpanded: true,
                          value: provider.currentMode,
                          items: const [
                            DropdownMenuItem(
                              value: ThemeMode.light,
                              child: Text(
                                'Light',
                                style: TextStyle(color: AppTheme.white),
                              ),
                            ),
                            DropdownMenuItem(
                              value: ThemeMode.dark,
                              child: Text(
                                'Dark',
                                style: TextStyle(color: AppTheme.white),
                              ),
                            ),
                          ],
                          onChanged: (newMode) {
                            if (newMode != null) {
                              provider.updateTheme(newMode);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32, color: Colors.grey),

                  InkWell(
                    onTap: () async {
                      Navigator.of(context).pop(); 

                      await context.read<AuthCubit>().logout();

                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.routeName,
                          (route) => false,
                        );
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout_rounded,
                          size: 24,
                          color: AppTheme.white,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Logout',
                          style: textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 32, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}