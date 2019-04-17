<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">
<@c.page>
    <div class = "col-sm-12 mb-10">
        <h3><#if username == author>Your<#else>${author}</#if> Messages</h3>
        <#if username != author>
            <#if isSubscribed>
                <a href="/unsubscribe/${author}" class="btn btn-primary">Unsubscribe</a>
                <#else>
                    <#if username != author>
                        <a href="/subscribe/${author}" class="btn btn-primary">Subscribe</a>
                    </#if>
            </#if>
        </#if>
    </div>
    <div class="card-deck">
        <#list messages as message>
            <div class="col-sm-4 mt-2">
                <div class="card text-center bg-light border-secondary" style="width: 18rem;">
                    <h5 class="card-header">#${message.tag}</h5>
                    <#if message.filename??>
                        <img src="/img/${message.filename}" class="card-img-top">
                    </#if>
                    <div class="card-body text-success">
                        <p class="card-text">${message.text}</p>
                        <p>author:</p><a href="/messages/${message.authorName}">${message.authorName}</a>
                    </div>
                    <#if message.createdOn??>
                        <div class="card-footer">
                            <small class="text-muted">Created ${message.getCreatedOn()}</small>
                        </div>
                    </#if>
                </div>
            </div>
        </#list>
    </div>
</@c.page>