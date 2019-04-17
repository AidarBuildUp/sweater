<#macro loginForm action_type sign_type isRegisterForm>
    <form action="${action_type}" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label" for="inputUsername"> User Name : </label>
            <div class="col-sm-6">
                <input class="form-control mt-2 mr-2 mr-sm-2 ${(usernameError??)?then("is-invalid","")}" type="text"
                       id="inputUsername" name="username" placeholder="input user name"
                       value="<#if user??>${(user.username??)?then(user.username,'')}</#if>"/>
                <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>
        </div>
        <#if isRegisterForm>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label" for="inputEmail"> Email : </label>
                <div class="col-sm-6">
                    <input type="text" class="form-control mt-2 mr-2 mr-sm-2 ${(mailError??)?then("is-invalid","")}"
                           id="inputEmail" name="mail" placeholder="some@some.com"
                           value="<#if user??>${(user.mail??)?then(user.mail,'')}</#if>"/>
                    <#if mailError??>
                        <div class="invalid-feedback">
                            ${mailError}
                        </div>
                    </#if>
                </div>
            </div>
        </#if>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label" for="inputPassword"> Password: </label>
            <div class="col-sm-6">
                <input type="password" class="form-control mt-2 mr-2 mr-sm-2 ${(passwordError??)?then("is-invalid","")}"
                       id="inputPassword" name="password" placeholder="input password"/>
                <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
                </#if>
            </div>
        </div>
            <#if isRegisterForm>
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label" for="inputPassword2"> Password Confirmation: </label>
                    <div class="col-sm-6">
                        <input type="password" class="form-control mt-2 mr-sm-2 ${(password2Error??)?then("is-invalid","")}"
                               id="inputPassword2" name="passwordConfirmation" placeholder="input password confirmation"/>
                        <#if password2Error??>
                            <div class="invalid-feedback">
                                ${password2Error}
                            </div>
                        </#if>
                    </div>
                        <div class="col-sm-10 ${(reCaptchaError??)?then('is-invalid','')}">
                            <div class="g-recaptcha" data-sitekey="6LehZJsUAAAAAL8MSFwRmI-ahmiBHOdPLY1atYtZ"></div>
                        </div>
                        <#if reCaptchaError??>
                            <div class="invalid-feedback col-sm-10">
                                ${reCaptchaError}
                            </div>
                        </#if>
                </div>
            </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button class="btn btn-primary mb-2" type="submit">${sign_type}</button>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button class="btn btn-primary ml-2" type="submit">Sign Out</button>
    </form>
</#macro>