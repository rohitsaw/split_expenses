import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../settings/groups_controller.dart';
import '../settings/settings_controller.dart';
import 'new_form.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
    required this.groupsController,
    required this.settingsController,
    required this.callback,
  });

  final GroupsController groupsController;
  final SettingsController settingsController;

  final Function(Map<String, dynamic>) callback;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 112,
            child: DrawerHeader(
              margin: const EdgeInsets.all(0.0),
              padding: const EdgeInsets.all(0.0),
              child: ListTile(
                // trailing: const Icon(Icons.edit),
                title: const Text('Groups'),
                onTap: () {},
              ),
            ),
          ),
          ...groupsController.groups.map((group) => ListTile(
                title: Text(group['name']),
                onTap: () {
                  callback(group);
                  Navigator.pop(context);
                },
              )),
          if (groupsController.groups.isNotEmpty) const Divider(),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Join group'),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(Icons.add_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => NewForm(
                        groupsController: groupsController,
                        saveButtonText: 'Join Group',
                        textFieldLabel: 'Invite Id',
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('Create group'),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(Icons.add_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => NewForm(
                        groupsController: groupsController,
                        saveButtonText: 'Create Group',
                        textFieldLabel: 'Group Name',
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            trailing: Transform.scale(
              scale: 0.8,
              child: Switch(
                value: settingsController.themeMode == ThemeMode.dark,
                onChanged: (val) {
                  if (val) {
                    settingsController.updateThemeMode(ThemeMode.dark);
                  } else {
                    settingsController.updateThemeMode(ThemeMode.light);
                  }
                },
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: const Text('Feedback'),
            onTap: () {
              if (Platform.isAndroid || Platform.isIOS) {
                final appId = Platform.isAndroid
                    ? 'developer.rohitsaw.split'
                    : 'YOUR_IOS_APP_ID';
                final url = Uri.parse(
                  Platform.isAndroid
                      ? "market://details?id=$appId"
                      : "https://apps.apple.com/app/id$appId",
                );
                launchUrl(
                  url,
                  mode: LaunchMode.externalApplication,
                );
              }
            },
          ),
          ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              // onTap: () async {
              //   final Uri url = Uri.parse('https://portfolio.rsaw409.me/about');
              //   if (!await launchUrl(url)) {
              //     throw Exception('Could not launch $url');
              //   }
              // },
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationVersion: '1.0.1+4',
                    applicationName: "Split Expenses",
                    applicationIcon: Image.asset(
                      'assets/images/split.webp',
                      width: 50,
                      height: 50,
                    ),
                    children: [
                      const Text('Key Features:'),
                      const Divider(),
                      const Text('Join or Create Group'),
                      const Text('Record and split expenses in groups.'),
                      const Text('Record payment made within  groups.'),
                      const Text('Overview Dashboard to settle up easliy.'),
                      const Divider(),
                      RichText(
                        text: TextSpan(
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'Made with  ',
                            ),
                            TextSpan(
                              text: '\u2764',
                              style: TextStyle(
                                fontFamily: 'EmojiOne',
                              ),
                            ),
                            TextSpan(
                              text: '  by rsaw409.',
                            ),
                          ],
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color),
                        ),
                      )
                    ]);
              }),
        ],
      ),
    );
  }
}
