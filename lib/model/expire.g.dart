// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expire.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpireAdapter extends TypeAdapter<Expire> {
  @override
  final int typeId = 0;

  @override
  Expire read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expire()
      ..name = fields[0] as String
      ..createdDate = fields[1] as DateTime
      ..days = fields[2] as int
      ..expiryDate = fields[3] as DateTime
      ..date = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Expire obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
      ..write(obj.days)
      ..writeByte(3)
      ..write(obj.expiryDate)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpireAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
