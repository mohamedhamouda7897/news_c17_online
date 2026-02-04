import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            color: Colors.white,
            child: Center(child: Text("News App")),
          ),
          SizedBox(height: 12),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 18, left: 12),
              height: double.infinity,
              width: double.infinity,
              color: Colors.black,
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
                        color: Colors.white,
                      ),
                    ),
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
