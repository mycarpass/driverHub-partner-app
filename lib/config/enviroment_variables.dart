abstract class DHEnvs {
  static const flavor = String.fromEnvironment(
    "APP_FLAVOR",
    defaultValue: "PRD",
  );

  static const apiBaseUrl = String.fromEnvironment("API_BASE_URL",
      defaultValue: "https://api.driverhub.com.br"
      // defaultValue: "https://homol.api.driverhub.com.br",
      );

  static const oneSignalToken = String.fromEnvironment("ONE_SIGNAL_TOKEN",
      defaultValue: "5517405b-d5cf-4f6f-b7cd-84b32a7ae99f"
      // defaultValue: "d625e208-30bd-40f5-b9c2-d014e8353e3e",
      );
}
