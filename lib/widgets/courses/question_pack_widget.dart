import 'package:bc_final_project/constants/r.dart';
import 'package:bc_final_project/models/question_pack_list_model.dart';
import 'package:bc_final_project/views/main/exercise/exercise_screen.dart';
import 'package:flutter/material.dart';

class QuestionPackWidget extends StatelessWidget {
  const QuestionPackWidget({
    Key? key,
    required this.data,
  }) : super(key: key);
  final QuestionPackData data;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExerciseScreen(id: data.exerciseId!),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        // margin: const EdgeInsets.all(13.0),
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.withOpacity(0.2)),
              padding: EdgeInsets.all(12),
              child: Image.asset(
                R.assets.icNote,
                width: 14,
              ),
            ),
            SizedBox(height: 4),
            Text(
              data.exerciseTitle!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${data.jumlahDone}/${data.jumlahSoal} Paket Soal",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                  color: R.colors.greySubtitleHome),
            ),
          ],
        ),
      ),
    );
  }
}
