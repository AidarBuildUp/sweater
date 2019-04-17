<#import "parts/common.ftl" as c>
<@c.page>
    <h5><#if username??>${username}</#if></h5>
    <form method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label" for="inputEmail"> Email : </label>
            <div class="col-sm-6">
                <input type="text" id="inputEmail" name="mail" placeholder="some@some.com" value="${mail!''}"/>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label" for="inputPassword"> Password: </label>
            <div class="col-sm-6">
                <input type="password" id="inputPassword" name="password" placeholder="input password"/>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button class="btn btn-primary mb-2" type="submit">Save</button>
    </form>
</@c.page>

