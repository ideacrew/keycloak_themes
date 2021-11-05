<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
    <div id="kc-form">
      <div id="kc-form-wrapper">
        <#if realm.password>
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <div class="${properties.kcFormGroupClass!}">
                    <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                    <#if usernameEditDisabled??>
                        <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}" type="text" disabled />
                    <#else>
                        <input tabindex="1" id="username" class="${properties.kcInputClass!}" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off"
                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                        />

                        <#if messagesPerField.existsError('username','password')>
                            <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                            </span>
                        </#if>
                    </#if>
                </div>

                <div class="${properties.kcFormGroupClass!}">
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>

                    <div class="password-tip">[ Password Hints ]
                        <span class="password-tip-text">
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Your password must:
                          <ul style="margin-block-start:0px ! important;">
                             <li>Be at least 8 characters</li>
                             <li>Not be longer than 20 characters</li>
                             <li>Include at least one lowercase letter</li>
                             <li>Include at least one uppercase letter</li>
                             <li>Include at least one number</li>
                             <li>Include at least one special character ($!@%*&amp;)</li>
                             <li>Cannot repeat any character more than 4 times</li>
                             <li>Not include blank spaces</li>
                             <li>Cannot contain username</li>
                          </ul>
                        </span>
                    </div>

                    <input tabindex="2" id="password" class="${properties.kcInputClass!}" name="password" type="password" autocomplete="off"
                           aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                    />
                </div>

                <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                    <div id="kc-form-options">
                        <#if realm.rememberMe && !usernameEditDisabled??>
                            <div class="checkbox">
                                <label>
                                    <#if login.rememberMe??>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                    <#else>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                    </#if>
                                </label>
                            </div>
                        </#if>
                        </div>
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                            <#if realm.resetPasswordAllowed>
                                <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                            </#if>
                        </div>

                  </div>

                  <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                      <input tabindex="6" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="button" onclick="window.location.href='https://qa-enroll.cme.openhbx.org/insured/consumer_role/privacy?uqhp=true';" value="Create Account" />
                      <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                      <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                  </div>
                  <div class="broker-box">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="12" cy="12" r="10" fill="#005689"/>
                        <path d="M14 7.20187C14 7.40619 13.9643 7.58956 13.8929 7.75197C13.8214 7.91438 13.7238 8.05583 13.6 8.17633C13.481 8.29159 13.3381 8.38065 13.1714 8.44352C13.0095 8.50639 12.8333 8.53782 12.6429 8.53782C12.4619 8.53782 12.2929 8.50901 12.1357 8.45138C11.9833 8.38851 11.85 8.30469 11.7357 8.1999C11.6262 8.08988 11.5381 7.96153 11.4714 7.81484C11.4095 7.66814 11.3786 7.50835 11.3786 7.33546C11.3786 7.13114 11.4119 6.94778 11.4786 6.78537C11.55 6.62296 11.6452 6.48412 11.7643 6.36886C11.8881 6.24837 12.0333 6.15668 12.2 6.09381C12.3667 6.03095 12.5476 5.99951 12.7429 5.99951C12.9238 5.99951 13.0905 6.03095 13.2429 6.09381C13.3952 6.15144 13.5262 6.23527 13.6357 6.34529C13.75 6.45007 13.8381 6.57581 13.9 6.7225C13.9667 6.86919 14 7.02898 14 7.20187ZM13.2571 17.7716C13.1714 17.7978 13.0714 17.824 12.9571 17.8502C12.8476 17.8764 12.7286 17.9 12.6 17.9209C12.4762 17.9471 12.3452 17.9655 12.2071 17.9759C12.0738 17.9917 11.9405 17.9995 11.8071 17.9995C11.4881 17.9995 11.2143 17.9524 10.9857 17.8581C10.7619 17.769 10.5762 17.6433 10.4286 17.4808C10.281 17.3132 10.1714 17.1167 10.1 16.8915C10.0333 16.6609 10 16.4095 10 16.137C10 16.0218 10.0048 15.8934 10.0143 15.752C10.0286 15.6105 10.0452 15.4638 10.0643 15.3119C10.0833 15.1547 10.1048 14.9975 10.1286 14.8404C10.1571 14.678 10.1857 14.5234 10.2143 14.3767C10.2333 14.2877 10.2643 14.1252 10.3071 13.8895C10.3548 13.6485 10.4071 13.3734 10.4643 13.0643C10.5262 12.7552 10.5905 12.4304 10.6571 12.0899C10.7238 11.7441 10.7857 11.4167 10.8429 11.1076C10.9048 10.7985 10.9571 10.526 11 10.2903C11.0476 10.0493 11.081 9.88425 11.1 9.79519H13.3857L12.5143 14.3217C12.4762 14.5051 12.4357 14.712 12.3929 14.9425C12.35 15.1678 12.3286 15.3643 12.3286 15.5319C12.3286 15.731 12.3857 15.8698 12.5 15.9484C12.6143 16.027 12.7452 16.0663 12.8929 16.0663C13.0167 16.0663 13.1405 16.0532 13.2643 16.027C13.3929 15.9956 13.5095 15.9563 13.6143 15.9091C13.5524 16.2235 13.4929 16.5352 13.4357 16.8443C13.3786 17.1482 13.319 17.4573 13.2571 17.7716Z" fill="white"/>
                    </svg>

                    <span>Brokers and Maine Enrollment Assisters <a tabindex="8" href="https://qa-enroll.cme.openhbx.org/benefit_sponsors/profiles/registrations/new?profile_type=broker_agency">register here</a></span> 
                  </div>
            </form>
        </#if>
        </div>

        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <hr/>
                <h4>${msg("identity-provider-login-label")}</h4>

                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                type="button" href="${p.loginUrl}">
                            <#if p.iconClasses?has_content>
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                                <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                            </#if>
                        </a>
                    </#list>
                </ul>
            </div>
        </#if>

    </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
