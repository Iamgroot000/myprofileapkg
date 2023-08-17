import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Project Page',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: ProjectPage(),
    );
  }
}

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  List<Map<String, String>> projects = [];

  TextEditingController projectTitleController = TextEditingController();
  TextEditingController projectDescriptionController = TextEditingController();
  TextEditingController projectLinkController = TextEditingController();
  TextEditingController technologiesUsedController = TextEditingController();
  TextEditingController editProjectTitleController = TextEditingController();
  TextEditingController editProjectDescriptionController =
  TextEditingController();
  TextEditingController editProjectLinkController = TextEditingController();
  TextEditingController editTechnologiesUsedController =
  TextEditingController();

  void addProject(String title, String description, String link,
      String technologiesUsed) {
    setState(() {
      projects.add({
        'title': title,
        'description': description,
        'link': link,
        'technologiesUsed': technologiesUsed,
      });
    });
  }

  void editProject(int index, String newTitle, String newDescription,
      String newLink, String newTechnologiesUsed) {
    setState(() {
      projects[index]['title'] = newTitle;
      projects[index]['description'] = newDescription;
      projects[index]['link'] = newLink;
      projects[index]['technologiesUsed'] = newTechnologiesUsed;
    });
  }

  void deleteProject(int index) {
    setState(() {
      projects.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Projects')),
      ),
      body: Center(
        child: Container(
          height: 800,
          width: 400,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.teal,
            ),
          ),
          child: Column(
            children: [
              TextField(
                controller: projectTitleController,
                decoration: InputDecoration(labelText: 'Project Title'),
              ),
              TextField(
                controller: projectDescriptionController,
                decoration: InputDecoration(labelText: 'Project Description'),
              ),
              TextField(
                controller: projectLinkController,
                decoration: InputDecoration(labelText: 'Project Link'),
              ),
              TextField(
                controller: technologiesUsedController,
                decoration: InputDecoration(labelText: 'Technologies Used'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addProject(
                    projectTitleController.text,
                    projectDescriptionController.text,
                    projectLinkController.text,
                    technologiesUsedController.text,
                  );
                  projectTitleController.clear();
                  projectDescriptionController.clear();
                  projectLinkController.clear();
                  technologiesUsedController.clear();
                },
                child: Text('Add Project'),
              ),
              SizedBox(height: 20),
              Text('Projects:'),
              Expanded(
                child: ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final title = projects[index]['title'] ?? '';
                    final description = projects[index]['description'] ?? '';
                    final link = projects[index]['link'] ?? '';
                    final technologiesUsed =
                        projects[index]['technologiesUsed'] ?? '';

                    return ListTile(
                      title: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(description),
                          Text('Link: $link'),
                          Text('Technologies Used: $technologiesUsed'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              editProjectTitleController.text = title;
                              editProjectDescriptionController.text =
                                  description;
                              editProjectLinkController.text = link;
                              editTechnologiesUsedController.text =
                                  technologiesUsed;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Edit Project'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: editProjectTitleController,
                                          decoration: InputDecoration(
                                              labelText: 'Project Title'),
                                        ),
                                        TextField(
                                          controller:
                                          editProjectDescriptionController,
                                          decoration: InputDecoration(
                                              labelText: 'Project Description'),
                                        ),
                                        TextField(
                                          controller: editProjectLinkController,
                                          decoration: InputDecoration(
                                              labelText: 'Project Link'),
                                        ),
                                        TextField(
                                          controller:
                                          editTechnologiesUsedController,
                                          decoration: InputDecoration(
                                              labelText: 'Technologies Used'),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          editProject(
                                            index,
                                            editProjectTitleController.text,
                                            editProjectDescriptionController.text,
                                            editProjectLinkController.text,
                                            editTechnologiesUsedController.text,
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
                              deleteProject(index);
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
