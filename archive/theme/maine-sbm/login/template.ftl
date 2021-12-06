<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html>
<html lang="en" class="${properties.kcHtmlClass!}">


<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <script
      src="https://apps.usw2.pure.cloud/widgets/9.0/cxbus.min.js"
      onload="javascript:CXBus.configure({debug:false,pluginsPath:'https://apps.usw2.pure.cloud/widgets/9.0/plugins/'}); CXBus.loadPlugin('widgets-core');"
    ></script>
</head>

<body class="${properties.kcBodyClass!}">
<div class="${properties.kcLoginClass!}">
    <div id="kc-header" class="${properties.kcHeaderClass!}">
        <div id="kc-header-wrapper"
             class="${properties.kcHeaderWrapperClass!}">${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}</div>
             <img class="client-logo" src="${url.resourcesPath}/img/logo.svg" alt="maine coverme logo" />
    </div>
    <div class="${properties.kcFormCardClass!}">
        <header class="${properties.kcFormHeaderClass!}">
            <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                <div class="${properties.kcLocaleMainClass!}" id="kc-locale">
                    <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
                        <div id="kc-locale-dropdown" class="${properties.kcLocaleDropDownClass!}">
                            <a href="#" id="kc-current-locale-link">${locale.current}</a>
                            <ul class="${properties.kcLocaleListClass!}">
                                <#list locale.supported as l>
                                    <li class="${properties.kcLocaleListItemClass!}">
                                        <a class="${properties.kcLocaleItemClass!}" href="${l.url}">${l.label}</a>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                    </div>
                </div>
            </#if>
        <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
            <#if displayRequiredFields>
                <div class="${properties.kcContentWrapperClass!}">
                    <div class="${properties.kcLabelWrapperClass!} subtitle">
                        <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                    </div>
                    <div class="col-md-10">
                        <h1 id="kc-page-title"><#nested "header"></h1>
                    </div>
                </div>
            <#else>
                <h1 id="kc-page-title"><#nested "header"></h1>
            </#if>
        <#else>
            <#if displayRequiredFields>
                <div class="${properties.kcContentWrapperClass!}">
                    <div class="${properties.kcLabelWrapperClass!} subtitle">
                        <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                    </div>
                    <div class="col-md-10">
                        <#nested "show-username">
                        <div id="kc-username" class="${properties.kcFormGroupClass!}">
                            <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                            <a id="reset-login" href="${url.loginRestartFlowUrl}">
                                <div class="kc-login-tooltip">
                                    <i class="${properties.kcResetFlowIcon!}"></i>
                                    <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            <#else>
                <#nested "show-username">
                <div id="kc-username" class="${properties.kcFormGroupClass!}">
                    <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                    <a id="reset-login" href="${url.loginRestartFlowUrl}">
                        <div class="kc-login-tooltip">
                            <i class="${properties.kcResetFlowIcon!}"></i>
                            <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                        </div>
                    </a>
                </div>
            </#if>
        </#if>
      </header>
      <div id="kc-content">
        <div id="kc-content-wrapper">

          <#-- App-initiated actions should not see warning messages about the need to complete the action -->
          <#-- during login.                                                                               -->
          <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
              <div class="alert-${message.type} ${properties.kcAlertClass!} pf-m-<#if message.type = 'error'>danger<#else>${message.type}</#if>">
                  <div class="pf-c-alert__icon">
                      <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                      <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                      <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                      <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                  </div>
                      <span class="${properties.kcAlertTitleClass!}">${kcSanitize(message.summary)?no_esc}</span>
              </div>
          </#if>

          <#nested "form">

            <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                    <div class="${properties.kcFormGroupClass!}">
                        <input type="hidden" name="tryAnotherWay" value="on"/>
                        <a href="#" id="try-another-way"
                           onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                    </div>
                </form>
            </#if>

          <#if displayInfo>
              <div id="kc-info" class="${properties.kcSignUpClass!}">
                  <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                      <#nested "info">
                  </div>
              </div>
          </#if>
        </div>
      </div>

    </div>
  </div>
  <script>
      window._genesys = {
        widgets: {
          webchat: {
            transport: {
              type: "purecloud-v2-sockets",
              dataURL: "https://api.usw2.pure.cloud",
              deploymentKey: "ed1c554f-7515-456d-ae71-168201f00bdb",
              orgGuid: "72ccb33f-2747-4e02-aa7e-4030bdc11f13",
              interactionData: {
                routing: {
                  targetType: "QUEUE",
                  targetAddress: "",
                  priority: 2,
                },
              },
            },
            userData: {
              addressStreet: "",
              addressCity: "",
              addressPostalCode: "",
              addressState: "",
              phoneNumber: "",
              customField1Label: "",
              customField1: "",
              customField2Label: "",
              customField2: "",
              customField3Label: "",
              customField3: "",
            },
          },
        },
      };

      function getAdvancedConfig() {
        return {
          form: {
            autoSubmit: false,
            firstname: "",
            lastname: "",
            email: "",
            subject: "",
          },
          formJSON: {
            wrapper: "<table></table>",
            inputs: [
              {
                id: "cx_webchat_form_firstname",
                name: "firstname",
                maxlength: "100",
                placeholder: "Required",
                label: "First Name",
                validateWhileTyping: false, // default is false
                validate: function (
                  event,
                  form,
                  input,
                  label,
                  $,
                  CXBus,
                  Common
                ) {
                  if (input) {
                    if (input.val()) return true;
                    else return false;
                  }
                  return false;
                },
              },
              {
                id: "cx_webchat_form_lastname",
                name: "lastname",
                maxlength: "100",
                placeholder: "Required",
                label: "Last Name",
                validateWhileTyping: false, // default is false
                validate: function (
                  event,
                  form,
                  input,
                  label,
                  $,
                  CXBus,
                  Common
                ) {
                  if (input) {
                    if (input.val()) return true;
                    else return false;
                  }
                  return false;
                },
              },
              {
                id: "cx_webchat_form_email",
                name: "email",
                maxlength: "100",
                placeholder: "Required",
                label: "Email",
                validateWhileTyping: false, // default is false
                validate: function (
                  event,
                  form,
                  input,
                  label,
                  $,
                  CXBus,
                  Common
                ) {
                  if (input) {
                    if (input.val()) return true;
                    else return false;
                  }
                  return false;
                },
              },
              {
                id: "cx_webchat_form_phoneNumber",
                name: "phonenumber",
                maxlength: "100",
                placeholder: "Optional",
                label: "Phone Number",
              },
              {
                id: "cx_webchat_form_coverMeID",
                name: "coverMeID",
                maxlength: "100",
                placeholder: "Optional",
                label: "CoverME.gov ID",
              },
              {
                id: "cx_webchat_form_customselect",
                name: "customselect",
                placeholder: "Required",
                label: "Topic",
                type: "select",
                required: "Please select an option",
                options: [
                  {
                    text: "Required",
                    hidden: "hidden",
                    value: "na",
                  },
                  {
                    text: "Manage my CoverME.gov Account",
                    value: "A",
                  },
                  {
                    text: "Open Enrollment & Eligibility",
                    value: "B",
                  },
                  {
                    text: "Documentation Questions",
                    value: "C",
                  },
                  {
                    text: "Special Enrollment Period (SEP)",
                    value: "D",
                  },
                ],

                validate: function (
                  event,
                  form,
                  input,
                  label,
                  $,
                  CXBus,
                  Common
                ) {
                  if (input != undefined) {
                    if (
                      document.getElementById("cx_webchat_form_customselect")
                        .value != "na"
                    )
                      return true;
                    else return false;
                  }
                  return false;
                },
                wrapper:
                  "<tr><th>{label}</th><td>{input}</td></tr>" /* input row wrapper */,
              },
            ],
          },
        };
      }

      const customPlugin = CXBus.registerPlugin("Custom");
    </script>

    <button class="live-chat-button" type="button" id="chat-button" onclick="customPlugin.command('WebChat.open', getAdvancedConfig());">

    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M13.25 14C12.0074 14 11 15.0074 11 16.25V17.752L11.0079 17.8604C11.3186 19.9866 13.2285 21.009 16.4332 21.009C19.6264 21.009 21.5667 19.9983 21.9855 17.8966L22 17.75V16.25C22 15.0074 20.9926 14 19.75 14H13.25ZM16.5 6C14.567 6 13 7.567 13 9.5C13 11.433 14.567 13 16.5 13C18.433 13 20 11.433 20 9.5C20 7.567 18.433 6 16.5 6Z" fill="white"/>
        <path d="M13.25 14C12.0074 14 11 15.0074 11 16.25V17.752L11.0079 17.8604C11.3186 19.9866 13.2285 21.009 16.4332 21.009C19.6264 21.009 21.5667 19.9983 21.9855 17.8966L22 17.75V16.25C22 15.0074 20.9926 14 19.75 14H13.25ZM13.25 15.5H19.75C20.1642 15.5 20.5 15.8358 20.5 16.25V17.6704C20.2202 18.8708 18.9494 19.509 16.4332 19.509C13.9171 19.509 12.7034 18.8777 12.5 17.6932V16.25C12.5 15.8358 12.8358 15.5 13.25 15.5ZM16.5 6C14.567 6 13 7.567 13 9.5C13 11.433 14.567 13 16.5 13C18.433 13 20 11.433 20 9.5C20 7.567 18.433 6 16.5 6ZM4.25 2C3.00736 2 2 3.00736 2 4.25V7.75C2 8.99264 3.00736 10 4.25 10H5.7049L7.87145 12.1414C8.36253 12.6266 9.15397 12.6219 9.63918 12.1308C9.87036 11.8968 10 11.5812 10 11.2526L10.0006 9.9862C11.1253 9.86155 12 8.90792 12 7.75V4.25C12 3.00736 10.9926 2 9.75 2H4.25ZM16.5 7.5C17.6046 7.5 18.5 8.39543 18.5 9.5C18.5 10.6046 17.6046 11.5 16.5 11.5C15.3954 11.5 14.5 10.6046 14.5 9.5C14.5 8.39543 15.3954 7.5 16.5 7.5ZM4.25 3.5H9.75C10.1642 3.5 10.5 3.83579 10.5 4.25V7.75C10.5 8.16421 10.1642 8.5 9.75 8.5H8.50137L8.5003 10.6539L6.3211 8.5H4.25C3.83579 8.5 3.5 8.16421 3.5 7.75V4.25C3.5 3.83579 3.83579 3.5 4.25 3.5Z" fill="white"/>
    </svg>
    ${msg("liveChatButton")}
    </button>
</body>
</html>
</#macro>
