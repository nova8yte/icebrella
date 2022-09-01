abstract class Gender {
  final String? sentence;
  final bool usePronouns;
  final String pronouns;

  Gender(this.pronouns, {this.sentence, this.usePronouns = false});
}

class MaleGender extends Gender {
  MaleGender() : super('he');
}

class FemaleGender extends Gender {
  FemaleGender() : super('she');
}

class OtherGender extends Gender {
  OtherGender(String pronouns) : super(pronouns);
}

class GenderSelector {
  final MaleGender maleGender;
  final FemaleGender femaleGender;
  final OtherGender otherGender;
  GenderSelector(this.maleGender, this.femaleGender, this.otherGender);

  Gender select(Type genderType) {
    switch (genderType) {
      case MaleGender:
        return maleGender;
      case FemaleGender:
        return femaleGender;
      case OtherGender:
        return otherGender;
      default:
        throw Exception('Not implemented $genderType genderType');
    }
  }
}
