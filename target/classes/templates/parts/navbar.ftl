<#import "loginForm.ftl" as l>
<#include "security.ftl">
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/">Sweater</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/main">Messages</a>
            </li>
            <#if know>
                <li class="nav-item">
                    <a class="nav-link" href="/messages/${username}">My messages</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/subscriptions">My subscriptions/subscribers</a>
                </li>
            </#if>
            <#if isAdmin>
                <li class="nav-item">
                    <a class="nav-link" href="/user/users">User list</a>
                </li>
            </#if>
        </ul>
        <div class="navbar-text">
            <#if user??>
                <a href="/user/profile">${username}</a>
                <#else> ${username}
            </#if>
        </div>
        <#if user??>
            <div class="form-inline">
                <@l.logout/>
            </div>
            <#else>
                <div>
                    <a class="ml-2" href="/login">Login</a>
                </div>
        </#if>
    </div>
</nav>