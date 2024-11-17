import 'package:path/path.dart' as path;

// Enum to represent file types
enum FileType {
  File,
  Folder,
}

class SourceArtefakt {
  String? name; // Name of the artefact
  String? description; // Description of the artefact
  FileType? type; // Type of the artefact (File or Folder)
  String url; // URL of the artefact
  String index; // Index of the artefact

  // Constructor
  SourceArtefakt(this.url, this.index) {
    name =
        path.basename(url); // Extract the name from the URL using path.basename
  }

  // Override the toString method to provide a custom string representation of the artefact
  @override
  String toString() =>
      'SourceArtefakt(name: $name, description: $description, type: $type, url: $url)';

  // Custom method to check equality with a string
  bool isEqual(String str) {
    return index == str; // Check if the index is equal to the provided string
  }
}
