<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="liveSupport.aspx.cs" Inherits="GrowSurv.liveSupport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="assets/pages/css/chat.css" rel="stylesheet" />
    <style type="text/css">
        .swal2-modal h2 {
            display: contents;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row" ng-app="globalApp" ng-cloak ng-controller="LiveSupportController">
        <asp:HiddenField ID="hdCurrentUserRole" ClientIDMode="Static" runat="server" />
        <div class="col-md-12">
            <div id="main-chat-div" class="chat" ng-if="SupportTickets.length > 0">
                <div id='chats'>
                    <header>
                        <i class='fa fa-search'></i>
                        <input type='search' ng-model="SupportTicketFilter" placeholder='Search' />
                    </header>
                    <ul class="chat-ul">
                        <li ng-class="{'chat-unread' : CurrSupportTicket.UnreadMessages > 0 , 'active actual' : currentSelectedTicketID == CurrSupportTicket.SupportTicketID }" ng-repeat="CurrSupportTicket in SupportTickets | filter : SupportTicketFilter" ng-click="getSupportMessages(CurrSupportTicket)">
                            <%if (Roles.IsUserInRole("admin"))
                                {
                            %>
                            <img class="img-responsive" src="assets/pages/img/user-img.png" />
                            <h1>{{CurrSupportTicket.UserName}}</h1>
                            <br />
                            <br />
                            <h2>{{CurrSupportTicket.TicketTitle}}</h2>

                            <%
                                }
                                else
                                {
                            %>
                            <img class="img-responsive" src="assets/pages/img/support.png" />
                            <h2 class="chat-wrap">{{CurrSupportTicket.TicketTitle}}</h2>
                            <%
                                }
                            %>

                            <span class="badge badge-primary badge-large chat-unread-count" ng-if="CurrSupportTicket.UnreadMessages>0">{{CurrSupportTicket.UnreadMessages}}
                            </span>
                        </li>
                        <%if (!Roles.IsUserInRole("admin"))
                            { %>

                        <li class="li-create-ticket" ng-click="AddNewTicketWithActiveTickets()">
                            <i class="fa fa-plus"></i>Create new ticket 
                        </li>
                        <%} %>
                    </ul>
                    <%--<span id='status'>Available</span>--%>
                </div>
                <div id='messages' ng-hide="SupportTicket.noSelection">
                    <header>
                        <%
                            if (Roles.IsUserInRole("admin"))
                            {
                        %>
                        <span><strong><b>{{SupportTicket.UserName}}</b> : {{SupportTicket.TicketTitle}}</strong></span>
                        <%}
                        else
                        {
                        %>
                        <span><strong>{{SupportTicket.TicketTitle}}</strong></span>

                        <%} %>
                        <a ng-if="!SupportTicket.IsClosed" class="btn btn-xs btn-outline red" ng-click="closeTicket()"><i class="icon-close"></i>Close Ticket</a>
                    </header>
                    <div class="chat-main">
                        <div class="msg-main" ng-repeat="Message in Messages">
                            <%
                                if (Roles.IsUserInRole("admin"))
                                {
                            %>
                            <i class="msg {{Message.FromAdmin ? 'msg-send' :'msg-receive'}}">{{Message.MessageContent}}
                            </i>
                            <%}
                            else
                            {
                            %>
                            <i class="msg {{Message.FromAdmin ? 'msg-receive' :'msg-send'}}">{{Message.MessageContent}}
                            </i>

                            <%} %>
                        </div>
                    </div>
                    <div id='msg' ng-class="{'ticket-closed-bg' : SupportTicket.IsClosed}">
                        <input autocomplete="off" type='text' ng-if="!SupportTicket.IsClosed" id="txtMessage" ng-model="Message.content" ng-keydown="$event.keyCode === 13 && sendMessage()" placeholder='Type a message' />
                        <img ng-if="!SupportTicket.IsClosed" src="assets/pages/img/send-img.png" ng-click="sendMessage()" class="chat-send-btn" />
                        <div class="ticket-closed" ng-if="SupportTicket.IsClosed">
                            Ticket closed on {{SupportTicket.LastMessageDate | date:'dd/MM/yyyy hh:mm a'}}
                        </div>
                    </div>
                </div>
            </div>
            <div class="portlet light" ng-if="SupportTickets.length == 0">
                <div class="portlet-title">
                    <div class="caption col-md-12">
                        <i class="icon-question font-blue"></i>
                        <span class="caption-subject font-blue sbold">Live Support</span>
                    </div>
                </div>
                <div class="portlet-body">
                    <div class="container-fluid">
                        <div class="col-md-12">
                            <div class="no-tickets">
                                <i class="fa fa-support no-tickets-icon"></i>
                                <br />
                                <br />
                                <p class="no-tickets-text">No tickets yet, create your first ticket !</p>
                                <a class="btn blue sbold btn-outline" href="#" ng-click="AddNewTicket()">
                                    <i class="fa fa-support"></i>
                                    Create Ticket </a>
                            </div>
                            <div class="first-ticket" hidden="hidden">
                                <div class="col-md-12">
                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                        <textarea class="form-control" id="form_control_2" ng-model="TicketSubject.title"></textarea>
                                        <label for="form_control_2">Your Ticket Subject</label>
                                    </div>
                                </div>
                                <div class="col-md-12 text-center">
                                    <a class="btn blue sbold" ng-disabled="!TicketSubject" href="#" ng-click="CreateNewTicket()">
                                        <i class="fa fa-support"></i>
                                        Create Ticket </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="AddNewTicketWithActiveTickets" class="portlet light" hidden="hidden">
                <div class="portlet-title">
                    <div class="caption col-md-12">
                        <i class="icon-question font-blue"></i>
                        <span class="caption-subject font-blue sbold">Live Support</span>
                    </div>
                </div>
                <div class="portlet-body">
                    <div class="container-fluid">
                        <div class="col-md-12">
                            <div class="first-ticket">
                                <div class="col-md-12">
                                    <div class="form-group form-md-line-input form-md-floating-label has-info">
                                        <textarea class="form-control" id="form_control_2" ng-model="TicketSubject.title"></textarea>
                                        <label for="form_control_2">Your Ticket Subject</label>
                                    </div>
                                </div>
                                <div class="col-md-12 text-center">
                                    <a class="btn blue sbold" ng-disabled="!TicketSubject" href="#" ng-click="CreateNewTicket()">
                                        <i class="fa fa-support"></i>
                                        Create Ticket </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="CPHScripts" runat="server">
    <script src="../scripts/angular.min.js"></script>
    <script src="../scripts/LiveSupportController.js"></script>
    <script src="../scripts/sweetalert2.min.js"></script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="CPHScriptsAfter" runat="server">
    <script src="../assets/global/plugins/counterup/jquery.waypoints.min.js" type="text/javascript"></script>
    <script src="../assets/global/plugins/counterup/jquery.counterup.min.js" type="text/javascript"></script>

</asp:Content>
