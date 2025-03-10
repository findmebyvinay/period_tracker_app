// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PeriodDataAdapter extends TypeAdapter<PeriodData> {
  @override
  final int typeId = 1;

  @override
  PeriodData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PeriodData(
      id: fields[0] as String,
      cycleStartDate: fields[1] as DateTime,
      cycleDuration: fields[3] as int,
      periodDuration: fields[2] as int,
      symptoms: (fields[4] as List).cast<SymptomLog>(),
      healthMetrics: (fields[5] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, PeriodData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cycleStartDate)
      ..writeByte(2)
      ..write(obj.periodDuration)
      ..writeByte(3)
      ..write(obj.cycleDuration)
      ..writeByte(4)
      ..write(obj.symptoms)
      ..writeByte(5)
      ..write(obj.healthMetrics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PeriodDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SymptomLogAdapter extends TypeAdapter<SymptomLog> {
  @override
  final int typeId = 2;

  @override
  SymptomLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SymptomLog(
      date: fields[0] as DateTime,
      symptomType: fields[1] as String,
      intensity: fields[2] as int,
      notes: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SymptomLog obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.symptomType)
      ..writeByte(2)
      ..write(obj.intensity)
      ..writeByte(3)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SymptomLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
