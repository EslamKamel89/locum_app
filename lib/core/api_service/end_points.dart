class EndPoint {
  static const String baseUrl = "http://10.0.2.2:8000/api";
  static const String imgBaseUrl = "http://10.0.2.2:8000/";
  // static const String baseUrl = "http://ampm.islamdev.com/api";
  static const String fetchSpecialties = "$baseUrl/specialties";
  static const String fetchStates = "$baseUrl/states";
  static const String fetchUniversities = "$baseUrl/universities";
  static const String fetchJobInfos = "$baseUrl/jobinfo";
  static const String fetchDistrictsData = "$baseUrl/districts";
  static const String fetchLangs = "$baseUrl/langs";
  static const String fetchSkills = "$baseUrl/skills";
  static const String signin = "$baseUrl/auth/login";
  static const String signup = "$baseUrl/auth/register";
  static const String userInfo = "$baseUrl/auth/user";
  static const String doctorInfoCreateOrUpdate = "$baseUrl/doctor-infos";
  static const String doctorCreateOrUpdate = "$baseUrl/doctors";
  static String doctorInfoUpdate(int? id) => "$baseUrl/doctor-infos/$id";
  static const String updateUser = "$baseUrl/auth/user";
  static const String hospitalCreateOrUpdate = "$baseUrl/hospitals";
  static const String hospitalInfoCreateOrUpdate = "$baseUrl/hospital-infos";
  static String showJobAdd(int id) => "$baseUrl/job-add/$id";
  static String showAllJobAdds = "$baseUrl/job-add";
  static String applyToJobAdd = "$baseUrl/job-applications";
  static String showDoctorJobApplication = "$baseUrl/job-applications";
}
