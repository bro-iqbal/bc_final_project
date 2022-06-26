import 'package:bc_final_project/models/course_list_model.dart';
import 'package:bc_final_project/views/main/exercise/question_pack_screen.dart';
import 'package:bc_final_project/widgets/courses/course_widget.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key, required this.mapel}) : super(key: key);
  static String route = "course_screen";

  final CourseListModel mapel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Mata Pelajaran"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20,
        ),
        child: ListView.builder(
            itemCount: mapel.data!.length,
            itemBuilder: (context, index) {
              final currentMapel = mapel.data![index];
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            QuestionPackScreen(id: currentMapel.courseId!),
                      ),
                    );
                  },
                  child: CourseWidget(
                    title: currentMapel.courseName!,
                    totalPacket: currentMapel.jumlahMateri!,
                    totalDone: currentMapel.jumlahDone!,
                  ));
            }),
      ),
    );
  }
}
