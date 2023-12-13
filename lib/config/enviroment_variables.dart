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
      defaultValue: "c4494182-3301-4c3a-a6e8-b01beebe2317"
      // defaultValue: "d625e208-30bd-40f5-b9c2-d014e8353e3e",
      );
}
