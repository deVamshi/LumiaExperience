// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installed_app_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InstalledAppModelAdapter extends TypeAdapter<InstalledAppModel> {
  @override
  final int typeId = 0;

  @override
  InstalledAppModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InstalledAppModel(
      appName: fields[0] as String,
      packageName: fields[1] as String,
      appIcon: fields[2] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, InstalledAppModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.appName)
      ..writeByte(1)
      ..write(obj.packageName)
      ..writeByte(2)
      ..write(obj.appIcon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InstalledAppModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
