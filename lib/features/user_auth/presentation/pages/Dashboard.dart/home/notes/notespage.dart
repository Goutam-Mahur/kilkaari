import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> _notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        backgroundColor: Color.fromARGB(255, 215, 239, 251),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 215, 239, 251),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _notes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: NoteCard(
                  title: _notes[index].title,
                  description: _notes[index].description,
                  onPressed: () {
                    // Add functionality to edit or delete note here
                  },
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddNotePage(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _navigateToAddNotePage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNotePage()),
    );
    if (result != null) {
      setState(() {
        _notes.add(result);
      });
    }
  }
}

class AddNotePage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.yellow[50], // Background color
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    style:
                        TextStyle(fontSize: 24), // Title text field font size
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title', // Placeholder text
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _descriptionController,
                    style: TextStyle(
                        fontSize: 20), // Description text field font size
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description', // Placeholder text
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Save note and navigate back to notes page
                      String title = _titleController.text;
                      String description = _descriptionController.text;
                      if (title.isNotEmpty || description.isNotEmpty) {
                        Navigator.pop(
                          context,
                          Note(title: title, description: description),
                        );
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressed;

  NoteCard(
      {required this.title,
      required this.description,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Note {
  final String title;
  final String description;

  Note({required this.title, required this.description});
}

void main() {
  runApp(MaterialApp(
    home: NotesPage(),
  ));
}
