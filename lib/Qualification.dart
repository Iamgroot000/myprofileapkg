import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qualification Page',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: QualificationPage(),
    );
  }
}

class QualificationPage extends StatefulWidget {
  @override
  _QualificationPageState createState() => _QualificationPageState();
}

class _QualificationPageState extends State<QualificationPage> {
  List<Map<String, String>> qualifications = [];

  TextEditingController universityController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController completionYearController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController qualificationDescriptionController =
  TextEditingController();
  TextEditingController editUniversityController = TextEditingController();
  TextEditingController editTitleController = TextEditingController();
  TextEditingController editBranchController = TextEditingController();
  TextEditingController editCompletionYearController = TextEditingController();
  TextEditingController editGradeController = TextEditingController();
  TextEditingController editDescriptionController = TextEditingController();

  void addQualification(
      String university,
      String title,
      String branch,
      String completionYear,
      String grade,
      String description) {
    setState(() {
      qualifications.add({
        'university': university,
        'title': title,
        'branch': branch,
        'completionYear': completionYear,
        'grade': grade,
        'description': description,
      });
    });
  }

  void editQualification(
      int index,
      String newUniversity,
      String newTitle,
      String newBranch,
      String newCompletionYear,
      String newGrade,
      String newDescription) {
    setState(() {
      qualifications[index]['university'] = newUniversity;
      qualifications[index]['title'] = newTitle;
      qualifications[index]['branch'] = newBranch;
      qualifications[index]['completionYear'] = newCompletionYear;
      qualifications[index]['grade'] = newGrade;
      qualifications[index]['description'] = newDescription;
    });
  }

  void deleteQualification(int index) {
    setState(() {
      qualifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('MyQualifications')),
      ),
      body: Center(
        child: Container(
          height: 800,
          width: 400,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.indigo,
            ),
          ),
          child: Column(
            children: [
              TextField(
                controller: universityController,
                decoration: InputDecoration(labelText: 'University'),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Qualification Title'),
              ),
              TextField(
                controller: branchController,
                decoration: InputDecoration(labelText: 'Branch'),
              ),
              TextField(
                controller: completionYearController,
                decoration: InputDecoration(labelText: 'Completion Year'),
              ),
              TextField(
                controller: gradeController,
                decoration: InputDecoration(labelText: 'Grade or Percentage'),
              ),
              TextField(
                controller: qualificationDescriptionController,
                decoration:
                InputDecoration(labelText: 'Qualification Description'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addQualification(
                    universityController.text,
                    titleController.text,
                    branchController.text,
                    completionYearController.text,
                    gradeController.text,
                    qualificationDescriptionController.text,
                  );
                  universityController.clear();
                  titleController.clear();
                  branchController.clear();
                  completionYearController.clear();
                  gradeController.clear();
                  qualificationDescriptionController.clear();
                },
                child: Text('Add Qualification'),
              ),
              SizedBox(height: 20),
              Text('Qualifications:'),
              Expanded(
                child: ListView.builder(
                  itemCount: qualifications.length,
                  itemBuilder: (context, index) {
                    final university = qualifications[index]['university'] ?? '';
                    final title = qualifications[index]['title'] ?? '';
                    final branch = qualifications[index]['branch'] ?? '';
                    final completionYear = qualifications[index]['completionYear'] ?? '';
                    final grade = qualifications[index]['grade'] ?? '';
                    final description = qualifications[index]['description'] ?? '';

                    return ListTile(
                      title: Text(
                        '$title at $university',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Branch: $branch'),
                          Text('Completion Year: $completionYear'),
                          Text('Grade/Percentage: $grade'),
                          Text(description),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              editUniversityController.text = university;
                              editTitleController.text = title;
                              editBranchController.text = branch;
                              editCompletionYearController.text = completionYear;
                              editGradeController.text = grade;
                              editDescriptionController.text = description;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Edit Qualification'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: editUniversityController,
                                          decoration: InputDecoration(
                                              labelText: 'University'),
                                        ),
                                        TextField(
                                          controller: editTitleController,
                                          decoration: InputDecoration(
                                              labelText: 'Qualification Title'),
                                        ),
                                        TextField(
                                          controller: editBranchController,
                                          decoration: InputDecoration(
                                              labelText: 'Branch'),
                                        ),
                                        TextField(
                                          controller:
                                          editCompletionYearController,
                                          decoration:
                                          InputDecoration(labelText: 'Completion Year'),
                                        ),
                                        TextField(
                                          controller: editGradeController,
                                          decoration: InputDecoration(
                                              labelText: 'Grade or Percentage'),
                                        ),
                                        TextField(
                                          controller: editDescriptionController,
                                          decoration: InputDecoration(
                                              labelText: 'Qualification Description'),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          editQualification(
                                            index,
                                            editUniversityController.text,
                                            editTitleController.text,
                                            editBranchController.text,
                                            editCompletionYearController.text,
                                            editGradeController.text,
                                            editDescriptionController.text,
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: Text('Update'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteQualification(index);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
