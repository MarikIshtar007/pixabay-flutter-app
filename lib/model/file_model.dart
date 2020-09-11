
class FileModel {
  final List<Files> files;
  final String folderName;

  FileModel({this.files, this.folderName});

  factory FileModel.fromJSON(Map<String, dynamic> json) {
    if (json['files'] != null) {
      var files = List<Files>();
      json['files'].forEach((v) => files.add(Files.fromJSON(v)));
      return FileModel(
        files: files,
        folderName: json['folderName'],
      );
    } else {
      return FileModel();
    }
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.files != null) {
      data['files'] = this.files.map((e) => e.toJSON()).toList();
    }
    data['folderName'] = this.folderName;
    return data;
  }
}

class Files {
  final String mimeType;
  final String size;
  final String title;
  final String path;

  Files({this.mimeType, this.size, this.title, this.path});

  factory Files.fromJSON(Map<String, dynamic> json) {
    return Files(
      mimeType: json['mimeType'],
      size: json['size'],
      title: json['title'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mimeType'] = this.mimeType;
    data['size'] = this.size;
    data['title'] = this.title;
    data['path'] = this.path;
    return data;
  }
}
