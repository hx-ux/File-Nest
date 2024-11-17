import 'package:isar/isar.dart';
import 'package:path/path.dart' as path;

part 'TargetArtefact.g.dart';
// A class representing a target artefact, extending the SourceArtefakt class
@collection
class TargetArtefact  {
 Id id = Isar.autoIncrement; // Für auto-increment kannst du auch id = null zuweisen 
  String url; // URL of the artefact
  String index;
  String? name;
  // Constructor
  TargetArtefact(this.url,this.index) {
    name = path.basename(url); // Extract the name from the URL using path.basename
   
  }
  // Override the toString method to provide a custom string representation of the artefact
  @override
  String toString() => 'TargetArtefact: { name: $name,  index: $index }';
  
}