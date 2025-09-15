import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ocrServiceProvider = Provider<OCRService>((ref) => OCRService());

class OCRService {
  // Replace with actual OCR integration (e.g., ML Kit Text Recognition)
  Future<String> extractText(File image) async {
    // Placeholder: In a real app, perform OCR and return extracted text
    return 'AMOXICILLIN 500mg\nTake one capsule every 8 hours after meals';
  }
}
