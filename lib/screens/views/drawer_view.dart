import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_c17_online/core/theming/cubit/cubit.dart';
import 'package:news_c17_online/core/theming/light_colors.dart';

class DrawerView extends StatelessWidget {
  Function onClick;

  DrawerView({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * .7,
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: ThemingCubit.get(context).colors.primary,
            child: Center(
              child: Text(
                "News App",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: ThemingCubit.get(context).colors.secondary,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 18, left: 12),
              height: double.infinity,
              width: double.infinity,
              color: ThemingCubit.get(context).colors.secondary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      onClick();
                    },
                    child: Text(
                      "Go To Home",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: ThemingCubit.get(context).colors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Divider(color: Colors.grey, thickness: 1),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Light Theme",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          color: ThemingCubit.get(context).colors.primary,
                        ),
                      ),
                      Switch(
                        value: ThemingCubit.get(context).colors is LightColors,
                        onChanged: (value) {
                          ThemingCubit.get(context).changeTheming();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Divider(color: Colors.grey, thickness: 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
