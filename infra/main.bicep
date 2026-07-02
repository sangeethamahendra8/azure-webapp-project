param serverfarms_sangeetha_asp_name string = 'sangeetha-asp'
param sites_sangeetha_webapp0701_name string = 'sangeetha-webapp0701'
param virtualNetworks_sangeetha_vnet_name string = 'sangeetha-vnet'
param components_sangeetha_webapp0701_name string = 'sangeetha-webapp0701'
param actionGroups_sangeetha_alerts_ag_name string = 'sangeetha-alerts-ag'
param metricAlerts_sangeetha_asp_cpu_alert_name string = 'sangeetha-asp-cpu-alert'
param userAssignedIdentities_oidc_msi_a1df_name string = 'oidc-msi-a1df'
param autoscalesettings_sangeetha_asp_Autoscale_882_name string = 'sangeetha-asp-Autoscale-882'
param actionGroups_Application_Insights_Smart_Detection_name string = 'Application Insights Smart Detection'
param workspaces_DefaultWorkspace_96cf92c5_3b4a_4a84_b204_fb037b4c8c89_CCAN_externalid string = '/subscriptions/96cf92c5-3b4a-4a84-b204-fb037b4c8c89/resourceGroups/DefaultResourceGroup-CCAN/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-96cf92c5-3b4a-4a84-b204-fb037b4c8c89-CCAN'

resource actionGroups_Application_Insights_Smart_Detection_name_resource 'microsoft.insights/actionGroups@2024-10-01-preview' = {
  name: actionGroups_Application_Insights_Smart_Detection_name
  location: 'Global'
  properties: {
    groupShortName: 'SmartDetect'
    enabled: true
    emailReceivers: []
    smsReceivers: []
    webhookReceivers: []
    eventHubReceivers: []
    itsmReceivers: []
    azureAppPushReceivers: []
    automationRunbookReceivers: []
    voiceReceivers: []
    logicAppReceivers: []
    azureFunctionReceivers: []
    armRoleReceivers: [
      {
        name: 'Monitoring Contributor'
        roleId: '749f88d5-cbae-40b8-bcfc-e573ddc772fa'
        useCommonAlertSchema: true
      }
      {
        name: 'Monitoring Reader'
        roleId: '43d0d8ad-25c7-4714-9337-8ba259a9fe05'
        useCommonAlertSchema: true
      }
    ]
  }
}

resource actionGroups_sangeetha_alerts_ag_name_resource 'microsoft.insights/actionGroups@2024-10-01-preview' = {
  name: actionGroups_sangeetha_alerts_ag_name
  location: 'Global'
  properties: {
    groupShortName: 'sgalerts'
    enabled: true
    emailReceivers: [
      {
        name: 'email-alert_-EmailAction-'
        emailAddress: 'G48238628@gwu.edu'
        useCommonAlertSchema: false
      }
    ]
    smsReceivers: []
    webhookReceivers: []
    eventHubReceivers: []
    itsmReceivers: []
    azureAppPushReceivers: []
    automationRunbookReceivers: []
    voiceReceivers: []
    logicAppReceivers: []
    azureFunctionReceivers: []
    armRoleReceivers: []
  }
}

resource components_sangeetha_webapp0701_name_resource 'microsoft.insights/components@2020-02-02' = {
  name: components_sangeetha_webapp0701_name
  location: 'canadacentral'
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Redfield'
    Request_Source: 'IbizaWebAppExtensionCreate'
    RetentionInDays: 90
    WorkspaceResourceId: workspaces_DefaultWorkspace_96cf92c5_3b4a_4a84_b204_fb037b4c8c89_CCAN_externalid
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource userAssignedIdentities_oidc_msi_a1df_name_resource 'Microsoft.ManagedIdentity/userAssignedIdentities@2025-05-31-preview' = {
  name: userAssignedIdentities_oidc_msi_a1df_name
  location: 'canadacentral'
  properties: {
    isolationScope: 'None'
    assignmentRestrictions: {
      providers: []
    }
  }
}

resource virtualNetworks_sangeetha_vnet_name_resource 'Microsoft.Network/virtualNetworks@2025-05-01' = {
  name: virtualNetworks_sangeetha_vnet_name
  location: 'canadacentral'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: [
      {
        name: 'default'
        id: virtualNetworks_sangeetha_vnet_name_default.id
        properties: {
          addressPrefixes: [
            '10.0.0.0/24'
          ]
          delegations: [
            {
              name: 'delegation'
              id: '${virtualNetworks_sangeetha_vnet_name_default.id}/delegations/delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverfarms'
              }
              type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
            }
          ]
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          defaultOutboundAccess: false
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource serverfarms_sangeetha_asp_name_resource 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: serverfarms_sangeetha_asp_name
  location: 'Canada Central'
  sku: {
    name: 'S1'
    tier: 'Standard'
    size: 'S1'
    family: 'S'
    capacity: 1
  }
  kind: 'linux'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    freeOfferExpirationTime: '2027-01-01T23:35:00'
    reserved: true
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
    asyncScalingEnabled: false
  }
}

resource autoscalesettings_sangeetha_asp_Autoscale_882_name_resource 'microsoft.insights/autoscalesettings@2022-10-01' = {
  name: autoscalesettings_sangeetha_asp_Autoscale_882_name
  location: 'Canada Central'
  properties: {
    profiles: [
      {
        name: 'Auto created default scale condition'
        capacity: {
          minimum: '1'
          maximum: '3'
          default: '1'
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'CpuPercentage'
              metricNamespace: 'microsoft.web/serverfarms'
              metricResourceUri: serverfarms_sangeetha_asp_name_resource.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT10M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: json('70')
              dimensions: []
              dividePerInstance: false
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT5M'
            }
          }
        ]
      }
    ]
    enabled: true
    name: autoscalesettings_sangeetha_asp_Autoscale_882_name
    targetResourceUri: serverfarms_sangeetha_asp_name_resource.id
    notifications: []
    predictiveAutoscalePolicy: {
      scaleMode: 'Disabled'
    }
  }
}

resource components_sangeetha_webapp0701_name_degradationindependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_sangeetha_webapp0701_name_resource
  name: 'degradationindependencyduration'
  location: 'canadacentral'
  properties: {
    ruleDefinitions: {
      Name: 'degradationindependencyduration'
      DisplayName: 'Degradation in dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    enabled: true
    sendEmailsToSubscriptionOwners: true
    customEmails: []
  }
}

resource components_sangeetha_webapp0701_name_degradationinserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_sangeetha_webapp0701_name_resource
  name: 'degradationinserverresponsetime'
  location: 'canadacentral'
  properties: {
    ruleDefinitions: {
      Name: 'degradationinserverresponsetime'
      DisplayName: 'Degradation in server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    enabled: true
    sendEmailsToSubscriptionOwners: true
    customEmails: []
  }
}

resource components_sangeetha_webapp0701_name_digestMailConfiguration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_sangeetha_webapp0701_name_resource
  name: 'digestMailConfiguration'
  location: 'canadacentral'
  properties: {
    ruleDefinitions: {
      Name: 'digestMailConfiguration'
      DisplayName: 'Digest Mail Configuration'
      Description: 'This rule describes the digest mail preferences'
      HelpUrl: 'www.homail.com'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    enabled: true
    sendEmailsToSubscriptionOwners: true
    customEmails: []
  }
}

resource components_sangeetha_webapp0701_name_extension_billingdatavolumedailyspikeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_sangeetha_webapp0701_name_resource
  name: 'extension_billingdatavolumedailyspikeextension'
  location: 'canadacentral'
  properties: {
    ruleDefinitions: {
      Name: 'extension_billingdatavolumedailyspikeextension'
      DisplayName: 'Abnormal rise in daily data volume (preview)'
      Description: 'This detection rule automatically analyzes the billing data generated by your application, and can warn you about an unusual increase in your application\'s billing costs'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/billing-data-volume-daily-spike.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    enabled: true
    sendEmailsToSubscriptionOwners: true
    customEmails: []
  }
}

resource components_sangeetha_webapp0701_name_extension_canaryextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_sangeetha_webapp0701_name_resource
  name: 'extension_canaryextension'
  location: 'canadacentral'
  properties: {
    ruleDefinitions: {
      Name: 'extension_canaryextension'
      DisplayName: 'Canary extension'
      Description: 'Canary extension'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    enabled: true
    sendEmailsToSubscriptionOwners: true
    customEmails: []
  }
}

resource components_sangeetha_webapp0701_name_extension_exceptionchangeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_sangeetha_webapp0701_name_resource
  name: 'extension_exceptionchangeextension'
  location: 'canadacentral'
  properties: {
    ruleDefinitions: {
      Name: 'extension_exceptionchangeextension'
      DisplayName: 'Abnormal rise in exception volume (preview)'
      Description: 'This detection rule automatically analyzes the exceptions thrown in your application, and can warn you about unusual patterns in your exception telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/abnormal-rise-in-exception-volume.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    enabled: true
    sendEmailsToSubscriptionOwners: true
    customEmails: []
  }
}

resource components_sangeetha_webapp0701_name_extension_memoryleakextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_sangeetha_webapp0701_name_resource
  name: 'extension_memoryleakextension'
  location: 'canadacentral'
  properties: {
    ruleDefinitions: {
      Name: 'extension_memoryleakextension'
      DisplayName: 'Potential memory leak detected (preview)'
      Description: 'This detection rule automatically analyzes the memory consumption of each process in your application, and can warn you about potential memory leaks or increased memory consumption.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/memory-leak.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    enabled: true
    sendEmailsToSubscriptionOwners: true
    customEmails: []
  }
}

resource components_sangeetha_webapp0701_name_extension_securityextensionspackage 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_sangeetha_webapp0701_name_resource
  name: 'extension_securityextensionspackage'
  location: 'canadacentral'
  properties: {
    ruleDefinitions: {
      Name: 'extension_securityextensionspackage'
      DisplayName: 'Potential security issue detected (preview)'
      Description: 'This detection rule automatically analyzes the telemetry generated by your application and detects potential security issues.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/application-security-detection-pack.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    enabled: true
    sendEmailsToSubscriptionOwners: true
    customEmails: []
  }
}

resource components_sangeetha_webapp0701_name_extension_traceseveritydetector 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_sangeetha_webapp0701_name_resource
  name: 'extension_traceseveritydetector'
  location: 'canadacentral'
  properties: {
    ruleDefinitions: {
      Name: 'extension_traceseveritydetector'
      DisplayName: 'Degradation in trace severity ratio (preview)'
      Description: 'This detection rule automatically analyzes the trace logs emitted from your application, and can warn you about unusual patterns in the severity of your trace telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/degradation-in-trace-severity-ratio.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    enabled: true
    sendEmailsToSubscriptionOwners: true
    customEmails: []
  }
}

resource components_sangeetha_webapp0701_name_longdependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_sangeetha_webapp0701_name_resource
  name: 'longdependencyduration'
  location: 'canadacentral'
  properties: {
    ruleDefinitions: {
      Name: 'longdependencyduration'
      DisplayName: 'Long dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    enabled: true
    sendEmailsToSubscriptionOwners: true
    customEmails: []
  }
}

resource components_sangeetha_webapp0701_name_migrationToAlertRulesCompleted 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_sangeetha_webapp0701_name_resource
  name: 'migrationToAlertRulesCompleted'
  location: 'canadacentral'
  properties: {
    ruleDefinitions: {
      Name: 'migrationToAlertRulesCompleted'
      DisplayName: 'Migration To Alert Rules Completed'
      Description: 'A configuration that controls the migration state of Smart Detection to Smart Alerts'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: true
      IsEnabledByDefault: false
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    enabled: false
    sendEmailsToSubscriptionOwners: true
    customEmails: []
  }
}

resource components_sangeetha_webapp0701_name_slowpageloadtime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_sangeetha_webapp0701_name_resource
  name: 'slowpageloadtime'
  location: 'canadacentral'
  properties: {
    ruleDefinitions: {
      Name: 'slowpageloadtime'
      DisplayName: 'Slow page load time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    enabled: true
    sendEmailsToSubscriptionOwners: true
    customEmails: []
  }
}

resource components_sangeetha_webapp0701_name_slowserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_sangeetha_webapp0701_name_resource
  name: 'slowserverresponsetime'
  location: 'canadacentral'
  properties: {
    ruleDefinitions: {
      Name: 'slowserverresponsetime'
      DisplayName: 'Slow server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    enabled: true
    sendEmailsToSubscriptionOwners: true
    customEmails: []
  }
}

resource userAssignedIdentities_oidc_msi_a1df_name_oidc_credential_aab9 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2025-05-31-preview' = {
  parent: userAssignedIdentities_oidc_msi_a1df_name_resource
  name: 'oidc-credential-aab9'
  properties: {
    issuer: 'https://token.actions.githubusercontent.com'
    subject: 'repo:sangeethamahendra8/azure-webapp-project:ref:refs/heads/main'
    audiences: [
      'api://AzureADTokenExchange'
    ]
  }
}

resource virtualNetworks_sangeetha_vnet_name_default 'Microsoft.Network/virtualNetworks/subnets@2025-05-01' = {
  name: '${virtualNetworks_sangeetha_vnet_name}/default'
  properties: {
    addressPrefixes: [
      '10.0.0.0/24'
    ]
    delegations: [
      {
        name: 'delegation'
        id: '${virtualNetworks_sangeetha_vnet_name_default.id}/delegations/delegation'
        properties: {
          serviceName: 'Microsoft.Web/serverfarms'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets/delegations'
      }
    ]
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    defaultOutboundAccess: false
  }
  dependsOn: [
    virtualNetworks_sangeetha_vnet_name_resource
  ]
}

resource sites_sangeetha_webapp0701_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-11-01' = {
  parent: sites_sangeetha_webapp0701_name_resource
  name: 'ftp'
  location: 'Canada Central'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/96cf92c5-3b4a-4a84-b204-fb037b4c8c89/resourceGroups/sangeetha-azureproj-rg/providers/microsoft.insights/components/sangeetha-webapp0701'
  }
  properties: {
    allow: false
  }
}

resource sites_sangeetha_webapp0701_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-11-01' = {
  parent: sites_sangeetha_webapp0701_name_resource
  name: 'scm'
  location: 'Canada Central'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/96cf92c5-3b4a-4a84-b204-fb037b4c8c89/resourceGroups/sangeetha-azureproj-rg/providers/microsoft.insights/components/sangeetha-webapp0701'
  }
  properties: {
    allow: true
  }
}

resource sites_sangeetha_webapp0701_name_web 'Microsoft.Web/sites/config@2024-11-01' = {
  parent: sites_sangeetha_webapp0701_name_resource
  name: 'web'
  location: 'Canada Central'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/96cf92c5-3b4a-4a84-b204-fb037b4c8c89/resourceGroups/sangeetha-azureproj-rg/providers/microsoft.insights/components/sangeetha-webapp0701'
  }
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    netFrameworkVersion: 'v4.0'
    linuxFxVersion: 'NODE|22-lts'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$sangeetha-webapp0701'
    scmType: 'GitHubAction'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetName: 'a918fbab-63c9-4f95-880e-260489edc7c6_default'
    vnetRouteAllEnabled: true
    vnetPrivatePortsCount: 0
    publicNetworkAccess: 'Enabled'
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 0
    elasticWebAppScaleLimit: 0
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 0
    azureStorageAccounts: {}
    http20ProxyFlag: 0
  }
}

resource sites_sangeetha_webapp0701_name_c7b5fca2_b8b3_4fa0_877f_03257402ffb3 'Microsoft.Web/sites/deployments@2024-11-01' = {
  parent: sites_sangeetha_webapp0701_name_resource
  name: 'c7b5fca2-b8b3-4fa0-877f-03257402ffb3'
  location: 'Canada Central'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'OneDeploy'
    message: 'OneDeploy'
    start_time: '2026-07-02T03:10:04.2622092Z'
    end_time: '2026-07-02T03:10:10.3221602Z'
    active: true
  }
}

resource sites_sangeetha_webapp0701_name_sites_sangeetha_webapp0701_name_drhng7dtajfrfyhf_canadacentral_01_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2024-11-01' = {
  parent: sites_sangeetha_webapp0701_name_resource
  name: '${sites_sangeetha_webapp0701_name}-drhng7dtajfrfyhf.canadacentral-01.azurewebsites.net'
  location: 'Canada Central'
  properties: {
    siteName: 'sangeetha-webapp0701'
    hostNameType: 'Verified'
  }
}

resource metricAlerts_sangeetha_asp_cpu_alert_name_resource 'microsoft.insights/metricAlerts@2024-03-01-preview' = {
  name: metricAlerts_sangeetha_asp_cpu_alert_name
  location: 'global'
  properties: {
    description: 'Alerts when CPU exceeds 70%'
    severity: 3
    enabled: true
    scopes: [
      serverfarms_sangeetha_asp_name_resource.id
    ]
    evaluationFrequency: 'PT1M'
    autoMitigate: true
    targetResourceType: 'Microsoft.Web/serverfarms'
    targetResourceRegion: 'canadacentral'
    actions: [
      {
        actionGroupId: actionGroups_sangeetha_alerts_ag_name_resource.id
        webHookProperties: {}
      }
    ]
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          operator: 'GreaterThan'
          threshold: json('70')
          name: 'Metric1'
          metricNamespace: 'Microsoft.Web/serverfarms'
          metricName: 'CpuPercentage'
          dimensions: []
          timeAggregation: 'Average'
          skipMetricValidation: false
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
    }
  }
}

resource sites_sangeetha_webapp0701_name_resource 'Microsoft.Web/sites@2024-11-01' = {
  name: sites_sangeetha_webapp0701_name
  location: 'Canada Central'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/96cf92c5-3b4a-4a84-b204-fb037b4c8c89/resourceGroups/sangeetha-azureproj-rg/providers/microsoft.insights/components/sangeetha-webapp0701'
  }
  kind: 'app,linux'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_sangeetha_webapp0701_name}-drhng7dtajfrfyhf.canadacentral-01.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_sangeetha_webapp0701_name}-drhng7dtajfrfyhf.scm.canadacentral-01.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_sangeetha_asp_name_resource.id
    reserved: true
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    outboundVnetRouting: {
      allTraffic: false
      applicationTraffic: true
      contentShareTraffic: false
      imagePullTraffic: false
      backupRestoreTraffic: false
    }
    siteConfig: {
      numberOfWorkers: 1
      linuxFxVersion: 'NODE|22-lts'
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 0
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientAffinityProxyEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    ipMode: 'IPv4'
    customDomainVerificationId: '39A69649DE1415D12BEF8FE1BE8428B8876C8060F05AEAD49AC12CEA4E280393'
    containerSize: 0
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    endToEndEncryptionEnabled: false
    redundancyMode: 'None'
    publicNetworkAccess: 'Enabled'
    storageAccountRequired: false
    virtualNetworkSubnetId: virtualNetworks_sangeetha_vnet_name_default.id
    keyVaultReferenceIdentity: 'SystemAssigned'
    autoGeneratedDomainNameLabelScope: 'TenantReuse'
  }
}

resource sites_sangeetha_webapp0701_name_a918fbab_63c9_4f95_880e_260489edc7c6_default 'Microsoft.Web/sites/virtualNetworkConnections@2024-11-01' = {
  parent: sites_sangeetha_webapp0701_name_resource
  name: 'a918fbab-63c9-4f95-880e-260489edc7c6_default'
  location: 'Canada Central'
  properties: {
    vnetResourceId: virtualNetworks_sangeetha_vnet_name_default.id
    isSwift: true
  }
}
