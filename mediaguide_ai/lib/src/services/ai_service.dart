import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiServiceProvider = Provider<AIService>((ref) => AIService());

class AIService {
  // Wire your LLM provider here (e.g., OpenAI, Azure OpenAI, etc.)
  // Use secure backend endpoints; avoid calling LLMs directly from client apps when possible.

  Future<String> askHealthCoach(String prompt) async {
    // Placeholder deterministic response for local dev
    return 'Here\'s guidance based on your input: "$prompt".\n\n'
        'Note: This is not medical advice. Consult a professional for urgent concerns.';
  }

  Future<String> explainMedication(String extractedText) async {
    if (extractedText.trim().isEmpty) {
      return 'No text found. Try re-scanning in good lighting.';
    }
    // Placeholder logic to pretend we parsed a drug name
    final firstLine = extractedText.split('\n').first;
    return 'Medication summary for "$firstLine":\n\n'
        '- Purpose: Example drug for symptomatic relief.\n'
        '- Common dose: As prescribed on the label.\n'
        '- Warnings: Check interactions, allergies, and consult a physician.';
  }
}
