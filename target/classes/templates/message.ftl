<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">
<@c.page>
<div class="collapse ${(message??)?then("show",'')}" id="collapseBlock">
    <form action="/main" class="form-group row" method="post" enctype="multipart/form-data">
        <div class="col-sm-10">
            <input type="text" class="form-control mt-2 mr-2 mr-sm-2 ${(textError??)?then("is-invalid","")}"
                   name="text" placeholder="Введите сообщение" value="<#if message?? && message.text??>${message.text}</#if>" />
            <#if textError??>
                <div class="invalid-feedback">
                    ${textError}
                </div>
            </#if>
        </div>
        <div class="col-sm-10">
            <input type="text" class="form-control mt-2 mr-2 mr-sm-2${(tagError??)?then(" is-invalid","")}"
                   name="tag" placeholder="Введите тег" value="<#if message?? && message.tag??>${message.tag}</#if>" />
            <#if tagError??>
                <div class="invalid-feedback">
                    ${tagError}
                </div>
            </#if>
        </div>

        <div class="custom-file col-sm-10 mb-2 mt-2">
            <input type="file" class="custom-file-input" id="customFile" name="file">
            <label class="custom-file-label" for="customFile">Choose file</label>
        </div>
        <div class="col-sm-10">
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <input type="hidden" name="id" value="<#if message?? && message.id??>${message.id}</#if>" />
            <button class="btn btn-primary mb-2" type="submit">Save</button>
        </div>
    </form>
</div>
</@c.page>