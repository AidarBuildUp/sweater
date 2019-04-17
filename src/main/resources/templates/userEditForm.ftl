<#import "parts/common.ftl" as c>
<@c.page>
    User edit form
    <form method="post" action="/user">
        <div><input type="hidden" value="${user.id}" name="userId"/></div>
        <div><input type="text" value="${user.username}" name="username"/></div>
        <#list roles as role>
            <div><label><input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked","")}/>${role}</label></div>
        </#list>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <div><input type="submit" value="Save"/></div>
    </form>
    <#--${message}-->
</@c.page>