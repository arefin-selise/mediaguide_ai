import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_service.dart';

class SymptomCheckerScreen extends ConsumerStatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  ConsumerState<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends ConsumerState<SymptomCheckerScreen> {
  final _controller = TextEditingController();
  String? _response;
  bool _loading = false;

  Future<void> _ask() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _loading = true);
    final res = await ref.read(aiServiceProvider).askHealthCoach(text);
    setState(() {
      _response = res;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Describe your symptoms or ask a question',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _loading ? null : _ask,
                  icon: const Icon(Icons.send),
                  label: const Text('Ask MediGuide'),
                ),
                const SizedBox(width: 12),
                if (_loading) const CircularProgressIndicator(),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: _response == null
                    ? const Text('Ask anything like: "I have a sore throat and fever, what should I do?"')
                    : SelectableText(_response!),
              ),
            )
          ],
        ),
      ),
    );
  }
}
