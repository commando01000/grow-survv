<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="GrowSurv.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
        <title>Grow Surv | User Login </title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="" name="description" />
        <meta content="" name="author" />
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <link href="../assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="../assets/global/css/components-md.min.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="../assets/global/css/plugins-md.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN PAGE LEVEL STYLES -->
        <link href="../assets/pages/css/login-5.min.css" rel="stylesheet" type="text/css" />
        <!-- END PAGE LEVEL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> 
    <!-- END HEAD -->
</head>
<body class="login">
    <form id="form1" runat="server">
    <div class="user-login-5">
            <div class="row bs-reset">
                <div class="col-md-6 bs-reset">
                    <div class="login-bg" style="background-image:url(../assets/pages/img/login/bg1.jpg)">
                        <%--<img class="login-logo" src="../assets/global/img/final_logo.png" /> --%></div>
                </div>
                <div class="col-md-6 login-container bs-reset">
                    <div class="login-content">
                        <div class="col-md-12 clearfix padding-tb-20">
                        <div class="col-lg-8">
                        <img src="../assets/global/img/final_logo.png" style="width:80%"/>  
                        </div>
                            <div class="col-lg-4" style="padding:5px !important;border: 1px solid #056838;border-radius:5px;">
                                a <img src="assets/pages/img/tcg.png" style="max-width:50%;"/> company
                            </div>
                            </div>
                        <h1>Grow Surv Login</h1>
                        <p> 
                            Conducting surveys is un biased approach to decision-making <br />
                            Don’t rely on your ‘feelings’ .. rely on our ‘surveys’

                        </p>
                        <asp:Login ID="Login1" runat="server">
                            <LayoutTemplate>
                                <div class="login-form" >
                            <div class="alert alert-danger display-hide">
                                <button class="close" data-close="alert"></button>
                                <span>Enter any username and password. </span>
                            </div>
                            <div class="row">
                                <div class="col-xs-6">
                                    <asp:TextBox runat="server" ID="UserName" CssClass="form-control form-control-solid placeholder-no-fix form-group" autocomplete="off" placeholder="Username" name="username" ></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ValidationGroup="Login1" ToolTip="User Name is required." ID="UserNameRequired">*</asp:RequiredFieldValidator>
                                                        
                                </div>
                                <div class="col-xs-6">
                                    <asp:TextBox runat="server" TextMode="Password" ID="Password" CssClass="form-control form-control-solid placeholder-no-fix form-group" autocomplete="off" placeholder="Password" name="password" ></asp:TextBox>
                                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ValidationGroup="Login1" ToolTip="Password is required." ID="PasswordRequired">*</asp:RequiredFieldValidator>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-5">
                                    <div class="rem-password">
                                        
                                            <asp:CheckBox runat="server" Text="Remember me " CssClass="rem-checkbox" ID="RememberMe"></asp:CheckBox>
                                        
                                    </div>
                                </div>
                                <div class="col-sm-7 text-right">
                                    
                                    <asp:Button CssClass="btn blue" runat="server" CommandName="Login" Text="Log In" ValidationGroup="Login1" ID="LoginButton"></asp:Button>                                    
                                </div>
                            </div>
                        </div> 
                                <div class="row">
                                    <asp:Literal runat="server" ID="FailureText" EnableViewState="False"></asp:Literal>

                                </div>
                                 </LayoutTemplate>
                        </asp:Login>
                        
                        <div class="col-md-12 clearfix padding-tb-20">
                        <div class="col-lg-8" style="font-size:18px;">
                         
                        </div>
                            </div>
                        <!-- BEGIN FORGOT PASSWORD FORM -->
                       
                        <!-- END FORGOT PASSWORD FORM -->
                    </div>
                    <div class="login-footer">
                        <div class="row bs-reset">
                           
                            <div class="col-xs-7 bs-reset">
                                <div class="login-copyright text-right">
                                    <p>Copyright &copy; <a href="http://q-bitware.com" target="_blank">
                    <img src="../assets/pages/img/qbitware-dark.png" style="max-height:20px;" />
                    
                </a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

         <!-- BEGIN FORGOT PASSWORD FORM -->
            <div class="forget-form" style="display:none;">
                <h3>Forget Password ?</h3>
                <p> Enter your e-mail address below to reset your password. </p>
                <div class="form-group">
                    <div class="input-icon">
                        <i class="fa fa-envelope"></i>
                         <asp:TextBox runat="server" ID="forget_email" CssClass="form-control placeholder-no-fix" autocomplete="off" placeholder="Email" name="forget_email" ></asp:TextBox>
                         <asp:RequiredFieldValidator runat="server" ControlToValidate="forget_email" ErrorMessage="User Name is required." ValidationGroup="forgetPass" ToolTip="User Name is required." ID="forget_UserNameRequired">*</asp:RequiredFieldValidator>                        
                    </div>
                </div>
                <div class="form-actions">
                    <button type="button" id="back-btn" class="btn grey-salsa btn-outline"> Back </button>
                    <asp:Button CssClass="btn green pull-right" runat="server" Text="Log In" ValidationGroup="forgetPass" ID="ForgetButton"></asp:Button>                                    

                </div>
            </div>
            <!-- END FORGOT PASSWORD FORM -->
            <!-- BEGIN REGISTRATION FORM -->
            <div class="register-form" style="display:none" >
                <h3>Sign Up</h3>
                <p> Enter your personal details below: </p>
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">Full Name</label>
                    <div class="input-icon">
                        <i class="fa fa-font"></i>
                         <asp:TextBox runat="server" ID="Reg_UserName" CssClass="form-control form-control-solid placeholder-no-fix form-group" autocomplete="off" placeholder="Username" name="reg_username" ></asp:TextBox>
                         <asp:RequiredFieldValidator runat="server" ControlToValidate="Reg_UserName" ErrorMessage="User Name is required." ValidationGroup="reg" ToolTip="User Name is required." ID="reg_UserNameRequired">*</asp:RequiredFieldValidator>
                                   

                    </div>
                </div>
                <div class="form-group">
                    <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                    <label class="control-label visible-ie8 visible-ie9">Email</label>
                    <div class="input-icon">
                        <i class="fa fa-envelope"></i>
                        <asp:TextBox runat="server" ID="Reg_txtMail" CssClass="form-control form-control-solid placeholder-no-fix form-group" autocomplete="off" placeholder="Email" name="reg_email" ></asp:TextBox>
                         <asp:RequiredFieldValidator runat="server" ControlToValidate="Reg_txtMail" ErrorMessage="Email is required." ValidationGroup="reg" ToolTip="email is required." ID="RequiredFieldValidator1">*</asp:RequiredFieldValidator>
                         </div>
                </div>
                <div class="form-group">
                    <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
                    <label class="control-label visible-ie8 visible-ie9">Telephone</label>
                    <div class="input-icon">
                        <i class="fa fa-phone"></i>
                        <asp:TextBox runat="server" ID="Reg_tele" CssClass="form-control form-control-solid placeholder-no-fix form-group" autocomplete="off" placeholder="Telephone" name="reg_tele" ></asp:TextBox>
                         <asp:RequiredFieldValidator runat="server" ControlToValidate="Reg_tele" ErrorMessage="Telephone is required." ValidationGroup="reg" ToolTip="Telepone is required." ID="RequiredFieldValidator2">*</asp:RequiredFieldValidator>
                         
                    </div>
                </div>
                
                <p> Enter your account details below: </p>
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">Username</label>
                    <div class="input-icon">
                        <i class="fa fa-user"></i>
                        <input class="form-control placeholder-no-fix" type="text" autocomplete="off" placeholder="Username" name="username" /> </div>
                </div>
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">Password</label>
                    <div class="input-icon">
                        <i class="fa fa-lock"></i>
                        <input class="form-control placeholder-no-fix" type="password" autocomplete="off" id="register_password" placeholder="Password" name="password" /> </div>
                </div>
                <div class="form-group">
                    <label class="control-label visible-ie8 visible-ie9">Re-type Your Password</label>
                    <div class="controls">
                        <div class="input-icon">
                            <i class="fa fa-check"></i>
                            <input class="form-control placeholder-no-fix" type="password" autocomplete="off" placeholder="Re-type Your Password" name="rpassword" /> </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>
                        <input type="checkbox" name="tnc" /> I agree to the
                        <a href="javascript:;"> Terms of Service </a> and
                        <a href="javascript:;"> Privacy Policy </a>
                    </label>
                    <div id="register_tnc_error"> </div>
                </div>
                <div class="form-actions">
                    <button id="register-back-btn" type="button" class="btn grey-salsa btn-outline"> Back </button>
                    <button type="submit" id="register-submit-btn" class="btn green pull-right"> Sign Up </button>
                </div>
            </div>
            <!-- END REGISTRATION FORM -->
    </form>
    <!-- BEGIN CORE PLUGINS -->
        <script src="../assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <%--<script src="../assets/global/plugins/jquery-validation/js/jquery.validate.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/jquery-validation/js/additional-methods.min.js" type="text/javascript"></script>--%>
        <script src="../assets/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
        <script src="../assets/global/plugins/backstretch/jquery.backstretch.min.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL SCRIPTS -->
        <script src="../assets/global/scripts/app.min.js" type="text/javascript"></script>
        <!-- END THEME GLOBAL SCRIPTS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="../assets/pages/scripts/login-5.js" type="text/javascript"></script>
        <!-- END PAGE LEVEL SCRIPTS -->
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <!-- END THEME LAYOUT SCRIPTS -->
</body>
</html>
