<#import "parts/common.ftl" as c>
<@c.page>
    <div class="col-sm-6 mt-2">
        <table class="table table-striped">
            <thead>
            <tr>
                <th scope="col">User</th>
                <th scope="col">Roles</th>
                <th scope="col">Modify</th>
            </tr>
            </thead>
            <tbody>
                <#list users as user>
                    <tr>
                        <td>${user.username}</td>
                        <td><#list user.roles as role>${role}<#sep>,</#list></td>
                        <td><a href="/user/${user.id}">edit</a></td>
                    </tr>
                </#list>
            </tbody>
        </table>
    </div>
</@c.page>