import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skills Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SkillsPage(),
    );
  }
}

class SkillsPage extends StatefulWidget {
  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  List<Map<String, String>> skillsAndProjects = [];

  TextEditingController skillController = TextEditingController();
  TextEditingController projectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController editController = TextEditingController();

  void addSkill(String skill) {
    setState(() {
      skillsAndProjects.add({'type': 'Skill', 'text': skill, 'description': ''});
    });
  }

  void addProject(String project, String description) {
    setState(() {
      skillsAndProjects.add({'type': 'Project', 'text': project, 'description': description});
    });
  }

  void editItem(int index, String newText, String newDescription) {
    setState(() {
      skillsAndProjects[index]['text'] = newText;
      skillsAndProjects[index]['description'] = newDescription;
    });
  }

  void deleteItem(int index) {
    setState(() {
      skillsAndProjects.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('MySkills')),
      ),
      body: Center(
        child: Container(
          height: 800,
          width: 400,
          //color: Colors.black,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
           // color: Colors.black,
            //color: Colors.black,

            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.deepPurple,
            ),
          ),
          child: Column(
            children: [
              TextField(
                controller: skillController,
                decoration: InputDecoration(labelText: 'Add Skill'),
              ),
              ElevatedButton(
                onPressed: () {
                  addSkill(skillController.text);
                  skillController.clear();
                },
                child: Text('Add Skill'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: projectController,
                decoration: InputDecoration(labelText: 'Add Project'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Add Project Description'),
              ),
              ElevatedButton(
                onPressed: () {
                  addProject(projectController.text, descriptionController.text);
                  projectController.clear();
                  descriptionController.clear();
                },
                child: Text('Add Project'),
              ),
              SizedBox(height: 20),
              Text('Skills & Projects:'),
              Expanded(
                child: ListView.builder(
                  itemCount: skillsAndProjects.length,
                  itemBuilder: (context, index) {
                    final text = skillsAndProjects[index]['text'] ?? ''; // Null check
                    final description = skillsAndProjects[index]['description'] ?? ''; // Null check

                    return ListTile(
                      title: Text(
                        text,
                        style: TextStyle(
                          fontWeight: skillsAndProjects[index]['type'] == 'Skill'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text(description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              editController.text = text;
                              descriptionController.text = description;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Edit Item'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: editController,
                                        ),
                                        TextField(
                                          controller: descriptionController,
                                          decoration: InputDecoration(labelText: 'Edit Project Description'),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          editItem(index, editController.text, descriptionController.text);
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
                              deleteItem(index);
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
// Function to save data to Firestore
Future<void> saveDataToFirestore(List<Map<String, String>> data) async {
  try {
    CollectionReference skillsCollection = FirebaseFirestore.instance.collection('skills');

    for (var item in data) {
      await skillsCollection.add({
        'type': item['type'],
        'text': item['text'],
        'description': item['description'],
      });
    }
  } catch (e) {
    print('Error saving data to Firestore: $e');
  }
}

// Function to fetch data from Firestore
Future<List<Map<String, String>>> fetchDataFromFirestore() async {
  List<Map<String, String>> result = [];

  try {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('skills').get();

    querySnapshot.docs.forEach((doc) {
      result.add({
        'type': doc['type'],
        'text': doc['text'],
        'description': doc['description'],
      });
    });
  } catch (e) {
    print('Error fetching data from Firestore: $e');
  }

  return result;
}