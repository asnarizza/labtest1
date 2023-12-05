import '../Controller/sqlite_db.dart';

class BmiCalc {

  // Define the table name for SQLite
  static const String SQLiteTable = "bmi";

  // Properties of a BMI calculation
  String username;
  double weight;
  double height;
  String gender;
  String bmi_status;

  // Constructor to initialize a BMI calculation
  BmiCalc (this.username, this.weight, this.height, this.gender, this.bmi_status);

  // Constructor to create a BmiCalc object from JSON data
  BmiCalc.fromJson(Map<String, dynamic> json)
      : username = json['_colUsername'] as String,
        weight = double.parse(json['_colWeight'].toString()),
        height = double.parse(json['_colHeight'].toString()),
        gender = json['_colGender'] as String,
        bmi_status = json['_colStatus'] as String;

  // Convert BmiCalc object to JSON
  Map<String, dynamic> toJson() =>
      {'_colUsername': username,
        '_colWeight': weight,
        '_colHeight': height,
        '_colGender': gender,
        '_colStatus': bmi_status,
      };

  // Function to save BMI data to local SQLite
  Future<bool> save() async {
    // Save to local SQLite database
    await SQLiteDB().insert(SQLiteTable, toJson());
    // Always return true for local save
    return true;

  }

  // Static function to load all BMI data from local SQLite
  static Future<List<BmiCalc>> loadAll() async {
    // Query all data from local SQLite
    List<Map<String, dynamic>> localResult =
    await SQLiteDB().queryAll(SQLiteTable);
    // Convert SQLite data to BmiCalc objects
    List<BmiCalc> result = localResult.map((item) =>
        BmiCalc.fromJson(item)).toList();

    return result;
  }

}




