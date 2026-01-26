var app = angular.module('globalApp', []);
app.controller('BankCategoriesController', function ($scope, $http, $rootScope) {
    $scope.Categories = [];
    $scope.Category = {};

    // Functions
    $scope.getAllQuestionCategories = function () {
        $http.post("/common/common.asmx/getAllBankCategories").then(function (Result) {
            $scope.Categories = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    };
    $scope.EditBankCategory = function (bankCategory) {
        $scope.Category = bankCategory;
    };
    $scope.SaveQuestionCategory = function () {
        if ($scope.Category.EnName) {
            $http.post("/common/common.asmx/SaveBankCategory", { model: $scope.Category }).then(function (Result) {
                if (Result.data == true) {
                    $scope.getAllQuestionCategories();
                    $scope.Category = {};
                }
                else
                    $rootScope.$emit("swAlertError", {});

            }, function () {
                $rootScope.$emit("swAlertError", {});
            });
        }
    }
    $scope.DeleteQuestionCategory = function (categoryID) {
        $rootScope.$emit("swConfirmDelete",
            {
                function() {
                    $http.post("/common/common.asmx/deleteBankCategory", { CategoryID: categoryID }).then(function (Result) {
                        if (Result.data == true) {
                            $rootScope.$emit("swAlertSave", {});         
                            $scope.getAllQuestionCategoriesBySurveyID();
                        }
                        else
                            $rootScope.$emit("swAlertSorry", {});

                    }, function () {
                        $rootScope.$emit("swAlertError", {});
                    });
                }
            });


    };
    $scope.CancelCategory = function () {
        $scope.Category = {};
    }

    /*Startup functions*/
    $scope.getAllQuestionCategories();

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