class DailyUpdate {
  late String  Signature;
  late String  Remark;
  late String  DSP;
  late String  DSC;
  late String  Uniform;
  late String  IdCard;

  DailyUpdate({
    required this.Signature,
    required this.Remark,
    required this.DSP,
    required this.DSC,
    required this.Uniform,
    required this.IdCard,
  });

  Map<String, dynamic> toMap() {
    return {
      "Signature": this.Signature,
      "Remark": this.Remark,
      "DSP": this.DSP,
      "DSC": this.DSC,
      "Uniform": this.Uniform,
      "IdCard": this.IdCard,

    };
  }

  DailyUpdate.fromMap(Map<String,dynamic> map){
    this.Signature=map["Signature"];
    this.Remark=map["Remark"];
    this.DSP=map["DSP"];
    this.DSC=map["DSC"];
    this.Uniform=map["Uniform"];
    this.IdCard=map["IdCard"];
  }


}