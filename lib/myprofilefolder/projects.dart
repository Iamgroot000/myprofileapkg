import 'package:flutter/material.dart';

class Project {
  final String title;
  final String description;

  Project({required this.title, required this.description});
}

class MyProjectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
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
  List<Project> projects = [];
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  void _addProject() {
    setState(() {
      projects.add(Project(title: _titleController.text, description: _descriptionController.text));
      _titleController.clear();
      _descriptionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Projects')),
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(project: projects[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return AnimatedPadding(
                duration: Duration(milliseconds: 300),
                padding: MediaQuery.of(context).viewInsets,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(labelText: 'Project Title'),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(labelText: 'Project Description'),
                        maxLines: 4,
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          Future.delayed(Duration(milliseconds: 200), () {
                            _addProject();
                            Navigator.pop(context);
                          });
                        },
                        child: Text('Add Project'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        tooltip: 'Add Project',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;

  ProjectCard({required this.project});

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          title: Text(widget.project.title),
          subtitle: Text(widget.project.description),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MyProjectApp());
}
