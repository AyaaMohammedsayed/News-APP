import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/core/Theme/app_theme.dart';


class HomeDrawer extends StatelessWidget {
  HomeDrawer({required this.resetModel});
  VoidCallback resetModel;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.7,
      color: AppTheme.black,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.sizeOf(context).height * 0.25,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(color: AppTheme.white),
            child: Text(
              textAlign: TextAlign.center,
              'New App',
              style: textTheme.headlineSmall!.copyWith(
                color: AppTheme.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                resetModel();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/svgs/home.svg'),
                  SizedBox(width: 8),
                  Text(
                    'Go To Home',
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
