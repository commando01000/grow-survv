<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="unauthorized.aspx.cs" Inherits="GrowSurv.doSurvey.unauthorized" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />        
        <link id="lnkCSS" runat="server" href = "../assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="col-lg-12" style="padding:15px;" >
            <div class="col-lg-2">
                <img src="../assets/global/img/final_logo.png" alt="logo" class="logo-default" style="max-height: 35px; -webkit-filter: drop-shadow(1px 1px 1px rgba(0, 0, 0, 0.70)); filter: drop-shadow(1px 1px 1px rgba(0, 0, 0, 0.70));" />
            </div>
            <div class="col-lg-8" >
        <div class="panel panel-info">
            <div class="panel-heading">Unauthorized Access</div>
            <div class="panel-body">
                UnAuthorized access. <br />Either you don't have permission to access this survey or you have submitted it before.
                <p>
                    For more info, please contact administrator.
                </p>

                <p class="text-center">
                    <a href="http://demo.growsurv.com" class="btn btn-primary">Continue</a>
                </p>
            </div>
        </div>

    </div>
        </div>
    
    </form>
</body>
</html>
