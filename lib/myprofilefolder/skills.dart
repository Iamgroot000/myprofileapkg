import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skills App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  TextEditingController _descriptionController = TextEditingController();
  List<SkillWithProjects> _skills = [];
  String? _highlightedSkill;

  void _addSkill(String skill, List<String> projects) {
    setState(() {
      _skills.add(SkillWithProjects(skill: skill, projects: projects));
      _highlightedSkill = skill;
    });
  }

  void _editSkill(int index, String newSkill, List<String> newProjects) {
    setState(() {
      _skills[index] = SkillWithProjects(skill: newSkill, projects: newProjects);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skills App'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _skills.length,
              itemBuilder: (context, index) {
                return SkillItem(
                  skill: _skills[index].skill,
                  projects: _skills[index].projects,
                  isHighlighted: _skills[index].skill == _highlightedSkill,
                  onEdit: (newSkill, newProjects) {
                    _editSkill(index, newSkill, newProjects);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return AddSkillDialog(
                onAdd: (skill, projects) {
                  _addSkill(skill, projects);
                  Navigator.pop(context);
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}







class SkillItem extends StatefulWidget {
  final String skill;
  final List<String> projects;
  final bool isHighlighted;
  final Function(String, List<String>) onEdit;

  SkillItem({required this.skill, required this.projects, required this.isHighlighted, required this.onEdit});

  @override
  _SkillItemState createState() => _SkillItemState();
}

class _SkillItemState extends State<SkillItem> {
  bool _isEditing = false;
  late TextEditingController _controller;
  late TextEditingController _projectsController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.skill);
    _projectsController = TextEditingController(text: widget.projects.join('\n'));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: _isEditing
          ? TextFormField(
        controller: _controller,
        onFieldSubmitted: (newSkill) {
          widget.onEdit(newSkill, widget.projects);
          setState(() {
            _isEditing = false;
          });
        },
      )
          : Text(
        widget.skill,
        style: TextStyle(
          color: widget.isHighlighted ? Colors.green : Colors.black,
        ),
      ),
      trailing: _isEditing
          ? IconButton(
        icon: Icon(Icons.check),
        onPressed: () {
          widget.onEdit(_controller.text, widget.projects);
          setState(() {
            _isEditing = false;
          });
        },
      )
          : IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          setState(() {
            _isEditing = true;
          });
        },
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Projects:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(widget.projects.join('\n')),
        ],
      ),
    );
  }
}

class AddSkillDialog extends StatefulWidget {
  final Function(String, List<String>) onAdd;

  AddSkillDialog({required this.onAdd});

  @override
  _AddSkillDialogState createState() => _AddSkillDialogState();
}

class _AddSkillDialogState extends State<AddSkillDialog> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _projectsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Skill'),
          ),
          TextFormField(
            controller: _projectsController,
            decoration: InputDecoration(labelText: 'Projects (separated by newline)'),
            maxLines: null,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              List<String> projects = _projectsController.text.split('\n').where((element) => element.trim().isNotEmpty).toList();
              widget.onAdd(_controller.text, projects);
            },
            child: Text('Add Skill'),
          ),
        ],
      ),
    );
  }
}

class SkillWithProjects {
  final String skill;
  final List<String> projects;

  SkillWithProjects({required this.skill, required this.projects});
}