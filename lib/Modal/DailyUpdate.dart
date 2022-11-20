class DailyUpdate {
  late String  Signature;
  late String  Remark;
  late String  DSP;
  late String  DSC;
  late String  Uniform;
  late String  IdCard;
  late String  Date;
  late String  Reward;
  late String  Penalty;

  DailyUpdate({
    required this.Signature,
    required this.Remark,
    required this.DSP,
    required this.DSC,
    required this.Uniform,
    required this.IdCard,
    required this.Date,
    required this.Reward,
    required this.Penalty,
  });

  Map<String, dynamic> toMap() {
    return {
      "Signature": this.Signature,
      "Remark": this.Remark,
      "DSP": this.DSP,
      "DSC": this.DSC,
      "Uniform": this.Uniform,
      "IdCard": this.IdCard,
      "Date": this.Date,
      "Reward": this.Reward,
      "Penalty": this.Penalty,

    };
  }

  DailyUpdate.fromMap(Map<String,dynamic> map){
    this.Signature=map["Signature"];
    this.Remark=map["Remark"];
    this.DSP=map["DSP"];
    this.DSC=map["DSC"];
    this.Uniform=map["Uniform"];
    this.IdCard=map["IdCard"];
    this.Date=map["Date"];
    this.Reward=map["Reward"];
    this.Penalty=map["Penalty"];
  }


}