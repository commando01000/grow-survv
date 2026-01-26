var app = angular.module('globalApp', []);
app.controller('BankQuestionsController', function ($scope, $http, $rootScope) {
    // Scope Variables
    $scope.QuestionTypes = [];
    $scope.QuestionCategories = [];
    $scope.searchQuery = "";
    $scope.Question = {};
    $scope.Questions = [];
    $scope.QuestionAnswer = {};
    $scope.QuestionAnswers = [];

    // Lookup Functions
    $scope.getAllQuestionCategories = function () {
        $http.post("/common/common.asmx/getAllBankCategories").then(function (Result) {
            $scope.QuestionCategories = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    };
    $scope.getAllQuestionTypes = function () {
        $http.post("/common/common.asmx/getAllQuestionTypes").then(function (Result) {
            $scope.QuestionTypes = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    };

    // Questions Functions
    $scope.getAllQuestions = function () {
        $http.post("/common/common.asmx/getBankQuestions", { searchQuery: $scope.searchQuery }).then(function (Result) {
            $scope.Questions = Result.data;
            $scope.McQuestions = [];
            for (var i = 0; i < $scope.Questions.length; i++) {
                if ($scope.Questions[i].QuestionTypeID != 1) {
                    $scope.McQuestions.push($scope.Questions[i]);
                }
            }
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    };
    $scope.CancelQuestion = function () {
        $scope.Question = {};
        $scope.QuestionAnswer = {};
        $scope.QuestionAnswers = [];
        HideMasterShowDetails("#QuestionDetails", "#QuestionList");
    }
    $scope.AddNewQuestion = function () {
        $scope.Question = {};
        $scope.QuestionAnswer = {};
        $scope.QuestionAnswers = [];
        HideMasterShowDetails("#QuestionList", "#QuestionDetails");
    }
    $scope.SaveQuestion = function () {
        $http.post("/common/common.asmx/SaveBankQuestion", { model: $scope.Question }).then(function (Result) {
            if (Result.status == 200) {
                $scope.getAllQuestions();
                $scope.CancelQuestion();
                $rootScope.$emit("swAlertSave", {});
            }
            else
                $rootScope.$emit("swAlertError", {});

        }, function () {
            $rootScope.$emit("swAlertError", {});
        });

    }
    $scope.editQuestion = function (model) {
        $scope.Question = model;
        $scope.getQuestionAnswersByQuestionID();
        //if ($scope.Question.QuestionTypeID == 5 || $scope.Question.QuestionTypeID == 6) {
        //    $scope.getSubQuestionByQuestionID();
        //}
        HideMasterShowDetails("#QuestionList", "#QuestionDetails");
        setTimeout(function () { $.uniform.update(); }, 300);
    }

    // Answers Functions
    $scope.getQuestionAnswersByQuestionID = function () {
        $http.post("/common/common.asmx/getBankAnswersByBankQuestionID", { QuestionID: $scope.Question.BankQuestionID }).then(function (Result) {
            $scope.QuestionAnswers = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }
    $scope.AddAnswer = function () {
        if (!$scope.Question.BankQuestionID) {
            $http.post("/common/common.asmx/SaveBankQuestion", { model: $scope.Question }).then(function (Result) {
                if (Result.status == 200) {
                    $scope.Question = Result.data;
                    if ($scope.QuestionAnswer.EnName) {
                        $scope.QuestionAnswer.BankQuestionID = $scope.Question.BankQuestionID;
                        $http.post("/common/common.asmx/SaveAnswers", { model: $scope.QuestionAnswer }).then(function (Result) {
                            if (Result.data == true) {
                                //$rootScope.$emit("swAlertSave", {});
                                $scope.getQuestionAnswersByQuestionID();
                                $scope.QuestionAnswer = {};
                            }
                            else
                                $rootScope.$emit("swAlertError", {});

                        }, function () {
                            $rootScope.$emit("swAlertError", {});
                        });
                    }
                }
            });
        } else {
            if ($scope.QuestionAnswer.EnName) {
                $scope.QuestionAnswer.BankQuestionID = $scope.Question.BankQuestionID;
                $http.post("/common/common.asmx/SaveBankAnswer", { model: $scope.QuestionAnswer }).then(function (Result) {
                    if (Result.data == true) {
                        //$rootScope.$emit("swAlertSave", {});
                        $scope.getQuestionAnswersByQuestionID();
                        $scope.QuestionAnswer = {};
                    }
                    else
                        $rootScope.$emit("swAlertError", {});

                }, function () {
                    $rootScope.$emit("swAlertError", {});
                });
            }
        }
    }
    $scope.editAnswer = function (model) {
        $scope.QuestionAnswer = model;
    }
    $scope.CancelAnswer = function () {
        $scope.QuestionAnswer = {};
        //$scope.getQuestionAnswersByQuestionID();
    }
    $scope.DeleteAnswer = function (model) {
        $rootScope.$emit("swConfirmDelete",
            {
                function() {
                    $scope.QuestionAnswer = model;
                    $http.post("/common/common.asmx/deleteBankAnswer", { AnswerID: $scope.QuestionAnswer.BankQuestionAnswerID }).then(function (Result) {
                        if (Result.data == true) {
                            $scope.getQuestionAnswersByQuestionID();
                        }
                        else
                            $rootScope.$emit("swAlertError", {});

                    }, function () {
                        $rootScope.$emit("swAlertError", {});
                    });
                }
            });
    }

    /*Startup functions*/
    $scope.getAllQuestionCategories();
    $scope.getAllQuestionTypes();
    $scope.getAllQuestions();

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
});


/* Utils */
function HideMasterShowDetails(panelToHide, panelToShow) {
    $(panelToHide).fadeOut(300, function () {
        $(panelToShow).fadeIn(300);
    });
}