<#import "parts/common.ftl" as c>
<#include "parts/security.ftl">
<@c.page>
    <form class="form-inline" method="get" action="/main">
        <input class="form-control col-sm-9 mr-2" type="text" name="filter" value="${(filter??)?then(filter,'')}">
        <button class="btn btn-primary" type="submit">Найти</button>
    </form>
    <button class="btn btn-primary mt-2" type="button" data-toggle="collapse" data-target="#collapseBlock" aria-expanded="false" aria-controls="collapseExample">
        Add new message
    </button>
    <div class="collapse ${(message??)?then("show",'')}" id="collapseBlock">
        <form class="form-group row" method="post" enctype="multipart/form-data">
            <div class="col-sm-10">
                <input type="text" class="form-control mt-2 mr-2 mr-sm-2 ${(textError??)?then("is-invalid","")}"
                       name="text" placeholder="Введите сообщение" value="<#if message??>${(message.text??)?then(message.text,'')}</#if>" />
                <#if textError??>
                    <div class="invalid-feedback">
                        ${textError}
                    </div>
                </#if>
            </div>
            <div class="col-sm-10">
                <input type="text" class="form-control mt-2 mr-2 mr-sm-2${(tagError??)?then(" is-invalid","")}"
                       name="tag" placeholder="Введите тег" value="<#if message??>${(message.tag??)?then(message.tag,'')}</#if>" />
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
                <button class="btn btn-primary mb-2" type="submit">Добавить</button>
            </div>
        </form>
    </div>
    <div class="card-deck">
        <#list messages as message>
            <div class="col-sm-4 mt-2">
                <div class="card text-center bg-light border-secondary" style="width: 18rem;">
                    <h5 class="card-header">#${message.tag}</h5>
                    <#if message.filename??>
                        <img src="/img/${message.filename}" class="card-img-top" alt="${message.authorName}">
                    </#if>
                    <div class="card-body text-success">
                        <p class="card-text">${message.text}</p>
                        <p>author: </p><a href="/messages/${message.authorName}">${message.authorName}</a>
                        <#if message.authorName == username>
                            <a href="/message/${message.id}">Edit</a>
                        </#if>
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