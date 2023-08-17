import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experience Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExperiencePage(),
    );
  }
}

class ExperiencePage extends StatefulWidget {
  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  List<Map<String, String>> experiences = [];

  TextEditingController companyController = TextEditingController();
  TextEditingController profileController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController experienceDescriptionController = TextEditingController();
  TextEditingController editCompanyController = TextEditingController();
  TextEditingController editProfileController = TextEditingController();
  TextEditingController editDurationController = TextEditingController();
  TextEditingController editDescriptionController = TextEditingController();

  void addExperience(
      String company, String profile, String duration, String description) {
    setState(() {
      experiences.add({
        'company': company,
        'profile': profile,
        'duration': duration,
        'description': description,
      });
    });
  }

  void editExperience(int index, String newCompany, String newProfile,
      String newDuration, String newDescription) {
    setState(() {
      experiences[index]['company'] = newCompany;
      experiences[index]['profile'] = newProfile;
      experiences[index]['duration'] = newDuration;
      experiences[index]['description'] = newDescription;
    });
  }

  void deleteExperience(int index) {
    setState(() {
      experiences.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('MyExperience')),
      ),
      body: Center(
        child: Container(
          height: 800,
          width: 400,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.blue,
            ),
          ),
          child: Column(
            children: [
              TextField(
                controller: companyController,
                decoration: InputDecoration(labelText: 'Company'),
              ),
              TextField(
                controller: profileController,
                decoration: InputDecoration(labelText: 'Job Profile'),
              ),
              TextField(
                controller: durationController,
                decoration: InputDecoration(labelText: 'Duration'),
              ),
              TextField(
                controller: experienceDescriptionController,
                decoration: InputDecoration(labelText: 'Experience Description'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addExperience(
                    companyController.text,
                    profileController.text,
                    durationController.text,
                    experienceDescriptionController.text,
                  );
                  companyController.clear();
                  profileController.clear();
                  durationController.clear();
                  experienceDescriptionController.clear();
                },
                child: Text('Add Experience'),
              ),
              SizedBox(height: 20),
              Text('Experiences:'),
              Expanded(
                child: ListView.builder(
                  itemCount: experiences.length,
                  itemBuilder: (context, index) {
                    final company = experiences[index]['company'] ?? '';
                    final profile = experiences[index]['profile'] ?? '';
                    final duration = experiences[index]['duration'] ?? '';
                    final description =
                        experiences[index]['description'] ?? '';

                    return ListTile(
                      title: Text(
                        '$profile at $company',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Duration: $duration'),
                          Text(description),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              editCompanyController.text = company;
                              editProfileController.text = profile;
                              editDurationController.text = duration;
                              editDescriptionController.text = description;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Edit Experience'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: editCompanyController,
                                          decoration: InputDecoration(
                                              labelText: 'Company'),
                                        ),
                                        TextField(
                                          controller: editProfileController,
                                          decoration: InputDecoration(
                                              labelText: 'Job Profile'),
                                        ),
                                        TextField(
                                          controller: editDurationController,
                                          decoration:
                                          InputDecoration(labelText: 'Duration'),
                                        ),
                                        TextField(
                                          controller: editDescriptionController,
                                          decoration: InputDecoration(
                                              labelText: 'Experience Description'),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          editExperience(
                                            index,
                                            editCompanyController.text,
                                            editProfileController.text,
                                            editDurationController.text,
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
                              deleteExperience(index);
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
