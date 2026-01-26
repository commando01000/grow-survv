var app = angular.module('globalApp', []);

app.controller('LiveSupportController', function ($scope, $http, $rootScope, $interval) {
    $scope.SupportTickets = [];
    $scope.SupportTicket = {
        noSelection : true
    };
    $scope.currentSelectedTicketID = 0;
    $scope.Messages = [];
    $scope.Message = {};
    $scope.TicketSubject = {};

    $scope.currentUserRole = $('#hdCurrentUserRole').val();
    $scope.IsAdmin = false;
    if ($scope.currentUserRole == "admin") {
        $scope.IsAdmin = true;
    }

    /* Main Functions */
    $scope.getSupportTickets = function () {
        $http.post("/common/common.asmx/getSupportTickets").then(function (Result) {
            $scope.SupportTickets = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }
    $scope.getSupportMessages = function (supportTicket) {
        $scope.SupportTicket = supportTicket;
        $scope.currentSelectedTicketID = supportTicket.SupportTicketID;
        $http.post("/common/common.asmx/getSupportMessages", { supportTicketID: supportTicket.SupportTicketID, isAdmin: $scope.IsAdmin }).then(function (Result) {
            $scope.Messages = Result.data;
            $scope.getSupportTickets();
            setTimeout(function () {
                $('.chat-main').scrollTop($('.chat-main')[0].scrollHeight);
                $('#txtMessage').focus();
            }, 50);
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    };
    $scope.sendMessage = function () {
        if ($scope.Message.content != "") {
            $scope.Messages.push({
                TicketMessageID: 0,
                SupportTicketID: $scope.SupportTicket.SupportTicketID,
                FromAdmin: $scope.IsAdmin,
                MessageContent: $scope.Message.content,
                MessageDate: Date.now()
            });
            setTimeout(function () {
                //$('.chat-main').scrollTop($('.chat-main')[0].scrollHeight);
                $('.chat-main').animate({ scrollTop: $('.chat-main').prop("scrollHeight") }, 100);
            }, 50);

            $('.chat-main').animate({ scrollTop: $('.chat-main').prop("scrollHeight") }, 200);

            $http.post("/common/common.asmx/sendMessage", {
                supportTicketID: $scope.SupportTicket.SupportTicketID,
                isAdmin: $scope.IsAdmin,
                messageContent: $scope.Message.content
            }).then(function (Result) {
                // TODO : send to signalR
                $scope.Message.content = "";
                $scope.getSupportTickets();
            }, function () {
                $rootScope.$emit("swAlertError", {});
            });
        }
    }
    $scope.closeTicket = function () {
        $rootScope.$emit("swConfirmClose",
            {
                function() {
                    $http.post("/common/common.asmx/closeTicket", {
                        supportTicketID: $scope.SupportTicket.SupportTicketID
                    }).then(function (Result) {
                        //$scope.getSupportTickets();
                        $scope.SupportTicket.IsClosed = true;
                        $('.chat-main').animate({ scrollTop: $('.chat-main').prop("scrollHeight") }, 100);
                    }, function () {
                        $rootScope.$emit("swAlertError", {});
                    });
                }
            });
    }

    $scope.AddNewTicketWithActiveTickets = function () {
        HideMasterShowDetails("#main-chat-div", "#AddNewTicketWithActiveTickets");
    }

    /* Client First Time Functions */
    $scope.AddNewTicket = function () {
        HideMasterShowDetails(".no-tickets", ".first-ticket");
    }
    $scope.CreateNewTicket = function () {
        $http.post("/common/common.asmx/createNewTicket", {
            TicketTitle: $scope.TicketSubject.title
        }).then(function (Result) {
            $scope.getSupportTickets();
            $scope.TicketSubject = {};
            HideMasterShowDetails(".first-ticket", ".no-tickets");
            HideMasterShowDetails("#AddNewTicketWithActiveTickets", "#main-chat-div");

        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }

    /*Startup functions*/
    $scope.getSupportTickets();

    // TODO: Should be implemented with SignalR
    //$interval(function () {
    //    if ($scope.currentSelectedTicketID != 0) {
    //        $scope.getSupportMessages($scope.currentSelectedTicketID);
    //    }
    //},10000)

    /*Events*/
    $rootScope.$on("swAlertSave", function () {
        swal({
            title: 'Saved Done Successfully !',
            type: 'success',
            timer: 2000,
            confirmButtonText: ' Ok !',
            confirmButtonColor: '#3598DC',
        })
    });
    $rootScope.$on("swAlertError", function () {
        swal({
            title: 'Unexpected Error Has Occurred',
            type: 'error',
            timer: 2000,
            confirmButtonText: ' Ok !',
            confirmButtonColor: '#3598DC',
        })
    });
    $rootScope.$on("swAlertSorry", function () {
        swal({
            title: 'Sorry',
            text: "This operation can not occur ! ",
            type: 'error',
            timer: 2000,
            confirmButtonText: 'Ok !',
            confirmButtonColor: '#3598DC',
        })
    });
    $rootScope.$on("swConfirmDelete", function (event, rAction) {
        swal({
            title: 'Delete Confirming',
            text: "This process is irreversible",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#E35B5A',
            cancelButtonColor: '#BFBFBF',
            confirmButtonText: '<i class="fa fa-check"></i> Delete',
            cancelButtonText: 'Cancel <i class="fa fa-chevron-right"></i>'
        }).then(
            function () { rAction.function() })
    });
    $rootScope.$on("swConfirmClose", function (event, rAction) {
        swal({
            title: 'Closing Ticket',
            text: "Are you sure you want to close the ticket ?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#E35B5A',
            cancelButtonColor: '#BFBFBF',
            confirmButtonText: '<i class="fa fa-check"></i> Delete',
            cancelButtonText: 'Cancel <i class="fa fa-chevron-right"></i>'
        }).then(
            function () { rAction.function() })
    });
});


/* Utils */
function HideMasterShowDetails(panelToHide, panelToShow) {
    $(panelToHide).fadeOut(300, function () {
        $(panelToShow).fadeIn(300);
    });
}