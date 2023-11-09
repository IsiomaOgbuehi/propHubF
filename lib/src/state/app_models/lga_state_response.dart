List<LGAsResponse> stateCapitalResponseFromJson(dynamic str) =>
    (str as List).map((e) => LGAsResponse.fromJson(e)).toList();

class LGAsResponse {
  LGAsResponse({
    required this.state,
  });

  final StateAndLGAs state;

  factory LGAsResponse.fromJson(Map<String, dynamic> json) =>
      LGAsResponse(state: StateAndLGAs.fromJson(json));
}

class StateAndLGAs {
  StateAndLGAs({
    required this.name,
    required this.locals,
  });

  final String name;
  final List<String> locals;

  factory StateAndLGAs.fromJson(Map<String, dynamic> json) => StateAndLGAs(
    name: json["state"],
    locals: (json["lgas"] as List).map((e) => e.toString()).toList(),
  );
}
