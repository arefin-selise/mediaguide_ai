import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../services/ocr_service.dart';
import '../services/ai_service.dart';

class MedicineScannerScreen extends ConsumerStatefulWidget {
  const MedicineScannerScreen({super.key});

  @override
  ConsumerState<MedicineScannerScreen> createState() => _MedicineScannerScreenState();
}

class _MedicineScannerScreenState extends ConsumerState<MedicineScannerScreen> {
  File? _image;
  String? _extractedText;
  String? _explanation;
  bool _loading = false;

  Future<void> _pick(ImageSource source) async {
    final picker = ImagePicker();
    final x = await picker.pickImage(source: source, imageQuality: 70);
    if (x == null) return;
    setState(() {
      _image = File(x.path);
      _extractedText = null;
      _explanation = null;
    });
  }

  Future<void> _scanAndExplain() async {
    if (_image == null) return;
    setState(() => _loading = true);
    final text = await ref.read(ocrServiceProvider).extractText(_image!);
    final explanation = await ref.read(aiServiceProvider).explainMedication(text);
    setState(() {
      _extractedText = text;
      _explanation = explanation;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => _pick(ImageSource.camera),
                icon: const Icon(Icons.photo_camera),
                label: const Text('Camera'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => _pick(ImageSource.gallery),
                icon: const Icon(Icons.photo_library),
                label: const Text('Gallery'),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _image == null || _loading ? null : _scanAndExplain,
                icon: const Icon(Icons.science),
                label: const Text('Scan & Explain'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_image != null) Image.file(_image!, height: 180),
          const SizedBox(height: 12),
          if (_loading) const LinearProgressIndicator(),
          if (_extractedText != null) ...[
            const Divider(),
            const Text('Extracted Text', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_extractedText!),
          ],
          if (_explanation != null) ...[
            const Divider(),
            const Text('Explanation', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_explanation!),
          ],
        ],
      ),
    );
  }
}
