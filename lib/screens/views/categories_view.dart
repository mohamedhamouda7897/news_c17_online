import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_c17_online/models/categories_model.dart';

class CategoriesView extends StatelessWidget {

  Function onClick;

  CategoriesView({super.key, required this.onClick});

  var categories = CategoryModel.getCategories();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Good Morning\nHere is Some News For You",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),

          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 12),

              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onClick(categories[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Stack(
                      alignment: index.isOdd
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      children: [
                        Stack(
                          alignment: index.isOdd
                              ? Alignment.bottomLeft
                              : Alignment.bottomRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(categories[index].image),
                            ),

                            Container(
                              padding: EdgeInsets.only(
                                left: index.isOdd ? 0 : 12,
                                right: index.isEven ? 0 : 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,

                                children: [
                                  Visibility(
                                    visible: index.isOdd,
                                    child: Image.asset(
                                      "assets/images/arrow_back.png",
                                    ),
                                  ),
                                  Text(
                                    " View All ",
                                    style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Visibility(
                                    visible: index.isEven,
                                    child: Image.asset(
                                        "assets/images/arrow.png"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 40.0, right: 30),
                          child: Text(
                            categories[index].label,
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
