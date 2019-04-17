<#import "parts/common.ftl" as c>
<#import "parts/loginForm.ftl" as l>
<@c.page>
Login page
    <@l.loginForm action_type="/login" sign_type="Вход" isRegisterForm=false/>
    <a href="/registration">Add new user</a>
    <div>
        <#if message??>
            <div class="alert alert-warning" role="alert">
                ${message}
            </div>
        </#if>
    </div>
</@c.page>
