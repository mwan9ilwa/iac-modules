ingress-nginx-validate-jwt:
  openIdProviderConfigurationUrl: https://${keycloak_fqdn}/realms/${keycloak_dfsp_realm_name}/.well-known/openid-configuration