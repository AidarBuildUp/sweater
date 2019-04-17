<#import "parts/common.ftl" as c>
<#import "parts/loginForm.ftl" as l>
<@c.page>
    Add new user
    <#if message??>
        <div class="alert alert-warning" role="alert">
            ${message}
        </div>
    </#if>
    <@l.loginForm action_type="/registration" sign_type="Регистрация" isRegisterForm=true/>
</@c.page>