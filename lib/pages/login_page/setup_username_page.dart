import 'package:flutter/material.dart';
import 'package:ministrar3/instances/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SetupUsernamePage extends StatefulWidget {
  const SetupUsernamePage({super.key});

  @override
  State<SetupUsernamePage> createState() => _SetupUsernamePageState();
}

class _SetupUsernamePageState extends State<SetupUsernamePage> {
  final _usernameController = TextEditingController();
  final _full_nameController = TextEditingController();

  var _loading = true;

  void _showSnackBar(String message, [bool isError = false]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Future<void> _getProfile() async {
    setState(() => _loading = true);

    try {
      final userId = supabase.auth.currentUser!.id;
      final data =
          await supabase.from('profiles').select().eq('id', userId).single();
      // here lines of code to save the data from user profile in riverpod
      _usernameController.text = (data['username'] ?? '') as String;
      _full_nameController.text = (data['full_name'] ?? '') as String;
    } catch (error) {
      _showSnackBar(
        error is PostgrestException
            ? error.message
            : 'Unexpected error occurred',
        true,
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _loading = true);

    final updates = {
      'id': supabase.auth.currentUser!.id,
      'username': _usernameController.text.trim(),
      'full_name': _full_nameController.text.trim(),
      'updated_at': DateTime.now().toIso8601String(),
    };

    try {
      await supabase.from('profiles').upsert(updates);
      _showSnackBar('Successfully updated profile!');
    } catch (error) {
      _showSnackBar(
        error is PostgrestException
            ? error.message
            : 'Unexpected error occurred',
        true,
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              children: [
                // fetch avatar url from riverpod
                // data['avatar_url'].isNotEmpty
                // ? CachedNetworkImage(
                //     imageUrl: providerImageUrl,
                //     placeholder: (context, url) => const Icon(
                //       Icons.account_circle,
                //       size: 40,
                //       color: primaryColor,
                //     ),
                //     width: 40, // Set the width and height as needed
                //     height: 50,
                //     fit: BoxFit.cover,
                //   )
                // : const Icon(
                //     Icons.account_circle,
                //     size: 40,
                //     color: primaryColor,
                //   ),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _full_nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: _loading ? null : _updateProfile,
                  child: Text(_loading ? 'Saving...' : 'Update'),
                ),
              ],
            ),
    );
  }
}
