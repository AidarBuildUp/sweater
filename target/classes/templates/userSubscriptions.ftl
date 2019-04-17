<#import "parts/common.ftl" as c>
<@c.page>
        <div class="col-sm-5 mt-2">
            <ul class="list-group">
                <li class="list-group-item list-group-item-primary">Your subcribers</li>
                <#if subscribers??>
                    <#list subscribers as subscriber>
                        <li class="list-group-item">
                            <a href="/messages/${subscriber.getUsername()}">${subscriber.getUsername()}</a>
                        </li>
                    </#list>
                <#else> <li class="list-group-item">No subscribers</li>
                </#if>
            </ul>
        </div>

        <div class="col-sm-5 mt-2">
            <ul class="list-group">
                <li class="list-group-item list-group-item-primary">Your subcriptions</li>
                <#if subscriptions??>
                    <#list subscriptions as subscription>
                        <li class="list-group-item">
                            <a href="/messages/${subscription.getUsername()}">${subscription.getUsername()}</a>
                        </li>
                    </#list>
                <#else> <li class="list-group-item">No subscriptions</li>
                </#if>
            </ul>
        </div>
</@c.page>