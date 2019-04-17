<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">
<@c.page>

    <h5>Hello, <#if username == "unknown">guest!<#else>${username}</#if></h5>
    <p>This is a simple clone of Twitter</p>
</@c.page>
