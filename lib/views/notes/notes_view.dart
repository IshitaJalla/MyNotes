import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learningdart/services/auth/auth_service.dart';
import 'package:learningdart/services/auth/bloc/auth_bloc.dart';
import 'package:learningdart/services/auth/bloc/auth_event.dart';
import 'package:learningdart/services/cloud/cloud_note.dart';
import 'package:learningdart/services/cloud/firebase_cloud_storage.dart';
import 'package:learningdart/utilities/dialogs/logout_dialog.dart';
import 'package:learningdart/views/notes/notes_list_view.dart';
import '../../constants/routes.dart';
import '../../enums/menu_action.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  String get userId => AuthService.firebase().currentUser!.id;

  late final FirebaseCloudStorage _notesService;
  @override //this is so that we open db while entering notes view
  void initState() {
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    context.read<AuthBloc>().add(
                          const AuthEventLogOut(),
                        );
                  }
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _notesService.allNotes(ownerUserId: userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              if (snapshot.hasData) {
                final allNotes = snapshot.data as Iterable<CloudNote>;
                return NotesListView(
                  notes: allNotes,
                  onDeleteNote: (note) async {
                    await _notesService.deleteNote(documentId: note.documentId);
                  },
                  onTap: (note) {
                    Navigator.of(context).pushNamed(
                      createOrUpdateNoteRoute,
                      arguments: note,
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              } //applicable for both the cases
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}






        //dont require futurebuilder for cloud as user already will be created
        //by default
        //         FutureBuilder(
        //   future: _notesService.getOrCreateUser(email: userEmail),
        //   builder: (context, snapshot) {
        //     switch (snapshot.connectionState) {
        //       case ConnectionState.done:
        //         return 

        //       default:
        //         return const CircularProgressIndicator();
        //     }
        //   },
        // )