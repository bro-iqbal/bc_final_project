import 'package:bc_final_project/constants/r.dart';
import 'package:flutter/material.dart';

class CourseWidget extends StatelessWidget {
  const CourseWidget({
    Key? key,
    required this.title,
    required this.totalDone,
    required this.totalPacket,
  }) : super(key: key);

  final String title;
  final int? totalDone;
  final int? totalPacket;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 21),
      child: Row(children: [
        Container(
          height: 53,
          width: 53,
          padding: EdgeInsets.all(13),
          decoration: BoxDecoration(
              color: R.colors.grey, borderRadius: BorderRadius.circular(10)),
          child: Image.asset(R.assets.icAtom),
        ),
        SizedBox(
          width: 6,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                "$totalDone/$totalPacket Paket latihan soal",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: R.colors.greySubtitleHome),
              ),
              SizedBox(height: 5),
              Stack(
                children: [
                  Container(
                    height: 5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: R.colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Container(
                    height: 5,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                        color: R.colors.primary,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
