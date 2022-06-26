import 'package:bc_final_project/constants/r.dart';
import 'package:bc_final_project/models/question_pack_list_model.dart';
import 'package:bc_final_project/models/responses.dart';
import 'package:bc_final_project/repositories/course_api.dart';
import 'package:bc_final_project/widgets/courses/question_pack_widget.dart';
import 'package:flutter/material.dart';

class QuestionPackScreen extends StatefulWidget {
  const QuestionPackScreen({Key? key, required this.id}) : super(key: key);
  static String route = "paket_soal_page";
  final String id;
  @override
  State<QuestionPackScreen> createState() => _QuestionPackScreenState();
}

class _QuestionPackScreenState extends State<QuestionPackScreen> {
  QuestionPackListModel? questionPackListModel;
  getPaketSoal() async {
    final mapelREsult = await CourseApi().getPaketSoal(widget.id);
    if (mapelREsult.status == Status.success) {
      questionPackListModel = QuestionPackListModel.fromJson(mapelREsult.data!);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPaketSoal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.grey,
      appBar: AppBar(
        title: Text("Paket Soal"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pilih Paket Soal",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
                child: questionPackListModel == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Wrap(
                          children: List.generate(
                              questionPackListModel!.data!.length, (index) {
                            final currentPaketSoal =
                                questionPackListModel!.data![index];
                            return Container(
                                padding: EdgeInsets.all(3),
                                width: MediaQuery.of(context).size.width * 0.4,
                                child:
                                    QuestionPackWidget(data: currentPaketSoal));
                          }).toList(),
                        ),
                      )

                // GridView.count(
                //     mainAxisSpacing: 10,
                //     crossAxisSpacing: 10,
                //     crossAxisCount: 2,
                //     childAspectRatio: 4 / 3,
                //     children:

                //     // [
                //     // PaketSoalWodget(),
                //     // PaketSoalWodget(),
                //     // PaketSoalWodget(),
                //     // PaketSoalWodget()
                //     // ],
                //     ),
                ),
          ],
        ),
      ),
    );
  }
}
