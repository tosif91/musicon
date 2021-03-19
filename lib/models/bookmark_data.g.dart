// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookMarkDataAdapter extends TypeAdapter<BookMarkData> {
  @override
  final int typeId = 0;

  @override
  BookMarkData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookMarkData(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookMarkData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.trackId)
      ..writeByte(1)
      ..write(obj.trackName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookMarkDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
