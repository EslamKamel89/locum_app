class UserModel {
	int? id;
	String? name;
	String? email;
	dynamic emailVerifiedAt;
	DateTime? createdAt;
	DateTime? updatedAt;
	dynamic stateId;
	dynamic districtId;
	String? token;

	UserModel({
		this.id, 
		this.name, 
		this.email, 
		this.emailVerifiedAt, 
		this.createdAt, 
		this.updatedAt, 
		this.stateId, 
		this.districtId, 
		this.token, 
	});

	@override
	String toString() {
		return 'UserModel(id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, createdAt: $createdAt, updatedAt: $updatedAt, stateId: $stateId, districtId: $districtId, token: $token)';
	}

	factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
				id: json['id'] as int?,
				name: json['name'] as String?,
				email: json['email'] as String?,
				emailVerifiedAt: json['email_verified_at'] as dynamic,
				createdAt: json['created_at'] == null
						? null
						: DateTime.parse(json['created_at'] as String),
				updatedAt: json['updated_at'] == null
						? null
						: DateTime.parse(json['updated_at'] as String),
				stateId: json['state_id'] as dynamic,
				districtId: json['district_id'] as dynamic,
				token: json['token'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'name': name,
				'email': email,
				'email_verified_at': emailVerifiedAt,
				'created_at': createdAt?.toIso8601String(),
				'updated_at': updatedAt?.toIso8601String(),
				'state_id': stateId,
				'district_id': districtId,
				'token': token,
			};
}
