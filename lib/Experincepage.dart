import 'package:flutter/material.dart';



class Experience {
  final String company;
  final String jobProfile;
  final String projectDescription;

  Experience(this.company, this.jobProfile, this.projectDescription);
}

class MyexperienceApp extends StatelessWidget {
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
  List<Experience> experiences = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Experience Page'),
      ),
      body: ListView.builder(
        itemCount: experiences.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(experiences[index].company),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(experiences[index].jobProfile),
                SizedBox(height: 4),
                Text(experiences[index].projectDescription),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddExperienceDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddExperienceDialog() {
    TextEditingController companyController = TextEditingController();
    TextEditingController jobProfileController = TextEditingController();
    TextEditingController projectDescriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Experience'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: companyController,
                decoration: InputDecoration(labelText: 'Company'),
              ),
              TextField(
                controller: jobProfileController,
                decoration: InputDecoration(labelText: 'Job Profile'),
              ),
              TextField(
                controller: projectDescriptionController,
                decoration: InputDecoration(labelText: 'Project Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  experiences.add(Experience(
                    companyController.text,
                    jobProfileController.text,
                    projectDescriptionController.text,
                  ));
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
