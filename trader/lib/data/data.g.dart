// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryAdapter extends TypeAdapter<History> {
  @override
  final int typeId = 0;

  @override
  History read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return History()
      ..currencyName = fields[0] as String
      ..margin = fields[1] as String
      ..leverage = fields[2] as String
      ..openedPrice = fields[3] as String
      ..closedPrice = fields[4] as String
      ..openedDate = fields[5] as String
      ..closedDate = fields[6] as String
      ..description = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, History obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.currencyName)
      ..writeByte(1)
      ..write(obj.margin)
      ..writeByte(2)
      ..write(obj.leverage)
      ..writeByte(3)
      ..write(obj.openedPrice)
      ..writeByte(4)
      ..write(obj.closedPrice)
      ..writeByte(5)
      ..write(obj.openedDate)
      ..writeByte(6)
      ..write(obj.closedDate)
      ..writeByte(7)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
