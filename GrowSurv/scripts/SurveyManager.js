var app = angular.module('globalApp', []);

app.controller('SurveyController', function ($scope, $http, $rootScope) {
    $scope.Survey = {};
    $scope.Surveys = [];
    $scope.SelectedCompany = $('#CurrentCompany').val() - 0;
    $scope.Companies = [];
    $scope.filterTxt = "";
    $scope.Question = {};
    $scope.Questions = [];
    $scope.McQuestions = [];
    $scope.QuestionTypes = [];
    $scope.QuestionCategories = [];
    $scope.QuestionCategory = {};
    $scope.QuestionBranches = [];
    $scope.QuestionBranch = {};
    $scope.QuestionAnswer = {};
    $scope.QuestionAnswers = [];
    $scope.SkipLogicQuestions = [];
    $scope.BranchingQuestions = [];
    $scope.BranchingQuestion = {};
    $scope.BranchingQuestionAnswers = [];
    $scope.SubQuestion = {};
    $scope.SubQuestions = [];
    $scope.SubQuestionAnswer = {};
    $scope.SubQuestionAnswers = [];
    $scope.PublishList = [];
    $scope.Mail = {};
    $scope.SurveyTypes = [];
    $scope.EditMode = false;
    $scope.PublishStatus = { PublishingToMember: false, PublishingToAll: false, MemberID: 0, SurveyID: 0 };

    $scope.ConList = [];
    $scope.GovList = [];
    $scope.BranchList = [];
    $scope.DeptList = [];
    $scope.DivList = [];
    $scope.AreaList = [];
    $scope.AgeList = [];
    $scope.LevelList = [];
    $scope.JobTitleList = [];
    $scope.GradeList = [];
    $scope.GenderList = [];

    // Properties for questions importing
    $scope.QuestionsToImport = [];
    $scope.BankQuestionsToImport = [];

    function hasHttpSuccess(result) {
        return result && result.status === 200;
    }

    function hasSurveyResult(result) {
        return hasHttpSuccess(result) && result.data && result.data.SurveyID;
    }

    function hasQuestionResult(result) {
        return hasHttpSuccess(result) && result.data && result.data.QuestionID;
    }

    /* Main Functions */
    $scope.getAllSurveys = function () {
        //$scope.SelectedCompany = document.getElementById("CurrentCompany").value;
        $http.post("/common/common.asmx/SearchSurveies", { filtertxt: $scope.filterTxt, CompanyID: $scope.SelectedCompany }).then(function (Result) {
            $scope.Surveys = Result.data;
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
    $scope.getAllSurveyTypes = function () {
        $http.post("/common/common.asmx/getAllSurveyTypes").then(function (Result) {
            $scope.SurveyTypes = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    };
    $scope.getAllBankQuestions = function () {
        $http.post("/common/common.asmx/getBankQuestions", { searchQuery: "" }).then(function (Result) {
            $scope.BankQuestionsToImport = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }
    function getAllCompanies() {
        $http.post("/common/common.asmx/getAllCompanies", { companyID: $scope.SelectedCompany }).then(function (Result) {
            $scope.Companies = Result.data;
            if (($('#CurrentCompany').val() - 0) != 0) {
                $scope.SelectedCompany = $('#CurrentCompany').val() - 0;
                $('#form_control_1').css('disabled', 'disabled');
                $('#filterCompany').css('disabled', 'disabled');
            }
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    };

    /* Surveys Main Data */
    $scope.EditSurvey = function (surveyID) {
        $http.post("/common/common.asmx/getSurvey", { SurveyID: surveyID }).then(function (Result) {
            $scope.Survey = Result.data;
            $scope.SelectedCompany = $scope.Survey.CompanyID;
            HideMasterShowDetails("#Listsurveys", "#SurveyDetails");
            $scope.getAllQuestions();
            $scope.getAllQuestionCategoriesBySurveyID();
            $scope.getAllQuestionBranchesBySurveyID();
            $scope.loadSkipLogicQuestions();
            $scope.getAllPublishList();
            $scope.getBranchingRules();
            $scope.getAllDemographicWeights();
            $scope.EditMode = true;
            setTimeout(function () { $.uniform.update(); }, 300);
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });

    };
    $scope.Cancel = function () {
        $scope.EditMode = false;
        $scope.Survey = {};
        $scope.Question = {};
        $scope.Questions = [];
        $scope.QuestionCategories = [];
        $scope.QuestionCategory = {};
        $scope.QuestionAnswer = {};
        $scope.QuestionAnswers = [];
        $scope.PublishList = [];
        $scope.QuestionBranches = [];
        $scope.QuestionBranch = {};
        HideMasterShowDetails("#SurveyDetails", "#Listsurveys");
    }
    $scope.AddNew = function () {
        $scope.Survey = {};
        $scope.Question = {};
        $scope.Questions = [];
        $scope.QuestionCategories = [];
        $scope.QuestionCategory = {};
        $scope.QuestionAnswer = {};
        $scope.QuestionAnswers = [];
        $scope.PublishList = [];
        $scope.QuestionBranches = [];
        $scope.QuestionBranch = {};
        HideMasterShowDetails("#Listsurveys", "#SurveyDetails");
    }
    $scope.Save = function () {
        if ($scope.SelectedCompany != 0)
            $scope.Survey.CompanyID = $scope.SelectedCompany;
        $http.post("/common/common.asmx/SaveSurvey", { model: $scope.Survey }).then(function (Result) {
            if (hasSurveyResult(Result)) {
                $rootScope.$emit("swAlertSave", {});
                if ($scope.EditMode == false) {
                    $scope.EditMode = true;
                    $scope.Survey = Result.data;
                } else {
                    $scope.Cancel();
                    $scope.getAllSurveys();
                }
            }
            else
                $rootScope.$emit("swAlertError", {});

        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }
    $scope.PublishSurvey = function (SurveyID) {


        $rootScope.$emit("swConfirmPublish",
            {
                function() {
                    $scope.PublishStatus.PublishingToAll = true;
                    $scope.PublishStatus.SurveyID = SurveyID;
                    $http.post("/common/common.asmx/PublishSurvey", { SurveyID: SurveyID }).then(function (Result) {
                        if (Result.data == true) {
                            $rootScope.$emit("swAlertPublish", {});
                        }
                        else
                            $rootScope.$emit("swAlertError", {});
                        $scope.PublishStatus.SurveyID = 0;
                        $scope.PublishStatus.PublishingToAll = false;

                    }, function () {
                        $scope.PublishStatus.SurveyID = 0;
                        $scope.PublishStatus.PublishingToAll = false;
                        $rootScope.$emit("swAlertError", {});
                    });
                }
            });



    }
    $scope.ViewReports = function (SurveyID) {
        window.location.href = "/survManager/reports.aspx?sid=" + SurveyID;
    }
    $scope.DuplicateSurvey = function (surveyID) {
        $http.post("/common/common.asmx/DuplicateSurvey", { SurveyID: surveyID }).then(function (Result) {
            if (Result.data === true) {
                $rootScope.$emit("swAlertSave", {});
                $scope.getAllSurveys();
            }
            else {
                $rootScope.$emit("swAlertError", {});
            }
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }

    /* Question Categories */
    $scope.getAllQuestionCategoriesBySurveyID = function () {
        $http.post("/common/common.asmx/getAllQuestionCategoriesBySurveyID", { SurveyID: $scope.Survey.SurveyID }).then(function (Result) {
            $scope.QuestionCategories = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    };
    $scope.AddQuestionCategory = function () {
        if ($scope.QuestionCategory.EnName) {
            $scope.QuestionCategory.SureveyID = $scope.Survey.SurveyID;
            $http.post("/common/common.asmx/SaveCategory", { model: $scope.QuestionCategory }).then(function (Result) {
                if (Result.data == true) {
                    $scope.getAllQuestionCategoriesBySurveyID();
                    $scope.QuestionCategory = {};
                }
                else
                    $rootScope.$emit("swAlertError", {});

            }, function () {
                $rootScope.$emit("swAlertError", {});
            });
        }
    }
    $scope.EditQuestionCategory = function (categoryID) {
        $http.post("/common/common.asmx/getQuestionCategory", { CategoryID: categoryID }).then(function (Result) {
            $scope.QuestionCategory = Result.data;
            //HideMasterShowDetails("#Listsurveys", "#SurveyDetails");            
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });

    };
    $scope.DeleteQuestionCategory = function (categoryID) {
        $rootScope.$emit("swConfirmDelete",
            {
                function() {
                    $http.post("/common/common.asmx/deleteQuestionCategory", { CategoryID: categoryID }).then(function (Result) {
                        if (Result.data == true) {
                            $rootScope.$emit("swAlertSave", {});//HideMasterShowDetails("#Listsurveys", "#SurveyDetails");            
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
    $scope.CancelQuestionCategory = function () {
        $scope.QuestionCategory = {};
    };
    $scope.duplicateQuestion = function (question) {
        $http.post("/common/common.asmx/duplicateQuestion", { QuestionID: question.QuestionID }).then(function (Result) {
            if (Result.data == true) {
                $scope.getAllQuestions();
                $rootScope.$emit("swAlertSave", {});
            }
            else
                $rootScope.$emit("swAlertError", {});
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }

    /* Questions */
    $scope.getAllQuestions = function () {
        $http.post("/common/common.asmx/getQuestions", { SurveyID: $scope.Survey.SurveyID }).then(function (Result) {
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
        HideMasterShowDetails("#QuestionList", "#QuestionDetails");
    }
    $scope.SaveQuestion = function () {
        $scope.Question.SurveyID = $scope.Survey.SurveyID;
        $http.post("/common/common.asmx/SaveQuestion", { model: $scope.Question }).then(function (Result) {
            if (hasQuestionResult(Result)) {
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
    $scope.UpdateQuestionsOrders = function () {
        $http.post("/common/common.asmx/UpdateQuestionsOrders", { model: $scope.Questions }).then(function (Result) {
            if (hasHttpSuccess(Result)) {
                $scope.getAllQuestions();
                $rootScope.$emit("swAlertSave", {});
            }
            else
                $rootScope.$emit("swAlertError", {});

        }, function () {
            $rootScope.$emit("swAlertError", {});
        });

    }
    $scope.deleteQuestion = function (model) {
        $rootScope.$emit("swCustomConfirmDelete",
            {
                function() {
                    $scope.Question = model;
                    $http.post("/common/common.asmx/deleteQuestion", { QuestionID: $scope.Question.QuestionID }).then(function (Result) {
                        if (Result.data == true) {
                            $scope.getAllQuestions();
                            $rootScope.$emit("swAlertSave", {});
                        }
                        else
                            $rootScope.$emit("swAlertError", {});

                    }, function () {
                        $rootScope.$emit("swAlertError", {});
                    });
                }
            },
            "all answers from respondents will be deleted with question"

        );

    }
    $scope.editQuestion = function (model) {
        $scope.Question = model;
        $scope.getQuestionAnswersByQuestionID();
        if ($scope.Question.QuestionTypeID == 5 || $scope.Question.QuestionTypeID == 6) {
            $scope.getSubQuestionByQuestionID();
        }
        HideMasterShowDetails("#QuestionList", "#QuestionDetails");
        setTimeout(function () { $.uniform.update(); }, 300);
    }

    /* Importing Question From Survey */
    $scope.AddNewImportedQuestion = function () {
        HideMasterShowDetails("#QuestionList", "#SurveyListToImportQuestion");
    }
    $scope.CancelImportQuestion = function () {
        HideMasterShowDetails("#SurveyListToImportQuestion", "#QuestionList");
    }
    $scope.showSurveyQuestionsToImport = function (SurveyID) {
        HideMasterShowDetails("#SurveyListToImportQuestion", "#QuestionsListToImportQuestion");

        $http.post("/common/common.asmx/getQuestions", { SurveyID: SurveyID }).then(function (Result) {
            $scope.QuestionsToImport = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }
    $scope.CancelImportQuestionInternal = function () {
        HideMasterShowDetails("#QuestionsListToImportQuestion", "#SurveyListToImportQuestion");
        $scope.QuestionsToImport = [];
    }
    $scope.importQuestion = function (model) {
        HideMasterShowDetails("#QuestionsListToImportQuestion", "#QuestionList");
        $http.post("/common/common.asmx/importQuestion", { QuestionID: model.QuestionID, NewSurveyID: $scope.Survey.SurveyID }).then(function (Result) {
            $scope.getAllQuestions();
            $rootScope.$emit("swAlertSave", {});
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
        $scope.QuestionsToImport = [];
    }
    $scope.importQuestionBulk = function () {
        $scope.tempList = [];
        for (var i = 0; i < $scope.QuestionsToImport.length; i++) {
            if ($scope.QuestionsToImport[i].IsChecked == true) {
                $scope.tempList.push($scope.QuestionsToImport[i].QuestionID);
            }
        }

        HideMasterShowDetails("#QuestionsListToImportQuestion", "#QuestionList");
        $http.post("/common/common.asmx/importQuestionBulk", { NewSurveyID: $scope.Survey.SurveyID, QuestionsIDList: $scope.tempList }).then(function (Result) {
            $scope.getAllQuestions();
            $rootScope.$emit("swAlertSave", {});
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
        $scope.QuestionsToImport = [];
    }

    /* Importing Question From Questions Bank */
    $scope.AddNewImportedQuestionFromBank = function () {
        HideMasterShowDetails("#QuestionList", "#QuestionsBankToImportQuestion");
    }
    $scope.CancelImportBankQuestion = function () {
        HideMasterShowDetails("#QuestionsBankToImportQuestion", "#QuestionList");
    }
    $scope.importBankQuestion = function (model) {
        HideMasterShowDetails("#QuestionsBankToImportQuestion", "#QuestionList");
        $http.post("/common/common.asmx/importBankQuestion", { QuestionID: model.BankQuestionID, NewSurveyID: $scope.Survey.SurveyID }).then(function (Result) {
            $scope.getAllQuestions();
            $rootScope.$emit("swAlertSave", {});
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
        $scope.QuestionsToImport = [];
    }
    $scope.importBankQuestionBulk = function () {
        $scope.tempList = [];
        for (var i = 0; i < $scope.BankQuestionsToImport.length; i++) {
            if ($scope.BankQuestionsToImport[i].IsChecked == true) {
                $scope.tempList.push($scope.BankQuestionsToImport[i].BankQuestionID);
            }
        }

        $http.post("/common/common.asmx/importBankQuestionBulk", { NewSurveyID: $scope.Survey.SurveyID, QuestionsIDList: $scope.tempList }).then(function (Result) {
            $scope.CancelImportBankQuestion();
            $scope.getAllQuestions();
            $rootScope.$emit("swAlertSave", {});
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
        for (var i = 0; i < $scope.BankQuestionsToImport.length; i++) {
            $scope.BankQuestionsToImport[i].IsChecked == false;
        }
    }


    /* Question Answers */
    $scope.getQuestionAnswersByQuestionID = function () {
        $http.post("/common/common.asmx/getQuestionAnswersByQuestionID", { QuestionID: $scope.Question.QuestionID }).then(function (Result) {
            $scope.QuestionAnswers = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }
    $scope.AddAnswer = function () {
        if (!$scope.Question.QuestionID) {
            $scope.Question.SurveyID = $scope.Survey.SurveyID;
            $http.post("/common/common.asmx/SaveQuestion", { model: $scope.Question }).then(function (Result) {
                if (hasQuestionResult(Result)) {
                    $scope.Question = Result.data;
                    if ($scope.QuestionAnswer.EnName) {
                        $scope.QuestionAnswer.QuestionID = $scope.Question.QuestionID;
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
                $scope.QuestionAnswer.QuestionID = $scope.Question.QuestionID;
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
    }
    $scope.editAnswer = function (model) {
        $scope.QuestionAnswer = model;
    }
    $scope.CancelAnswer = function () {
        $scope.QuestionAnswer = {};
        $scope.getQuestionAnswersByQuestionID();
    }
    $scope.DeleteAnswer = function (model) {
        $rootScope.$emit("swConfirmDelete",
            {
                function() {
                    $scope.QuestionAnswer = model;
                    $http.post("/common/common.asmx/deleteAnswer", { AnswerID: $scope.QuestionAnswer.AnswerID }).then(function (Result) {
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

    /* Sub-Questions */
    $scope.AddSubQuestion = function () {
        HideMasterShowDetails("#GridSubQuestionsMaster", "#GridSubQuestionsDetail");
    }
    $scope.CancelSubQuestion = function () {
        $scope.SubQuestion = {};
        $scope.SubQuestionAnswers = [];
        HideMasterShowDetails("#GridSubQuestionsDetail", "#GridSubQuestionsMaster");
    }
    $scope.getSubQuestionByQuestionID = function () {
        $http.post("/common/common.asmx/getSubQuestionByQuestionID", { QuestionID: $scope.Question.QuestionID }).then(function (Result) {
            $scope.SubQuestions = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });

    }
    $scope.SaveSubQuestion = function () {
        $scope.SubQuestion.ParentQuestionID = $scope.Question.QuestionID;
        $scope.SubQuestion.SurveyID = $scope.Survey.SurveyID;
        $http.post("/common/common.asmx/SaveQuestion", { model: $scope.SubQuestion }).then(function (Result) {
            if (hasQuestionResult(Result)) {
                $scope.getSubQuestionByQuestionID();
                $scope.CancelSubQuestion();
                $rootScope.$emit("swAlertSave", {});
            }
            else
                $rootScope.$emit("swAlertError", {});

        }, function () {
            $rootScope.$emit("swAlertError", {});
        });

    }
    $scope.editSubQuestion = function (model) {
        $scope.SubQuestion = model;
        HideMasterShowDetails("#GridSubQuestionsMaster", "#GridSubQuestionsDetail");
    }
    $scope.DeleteSubQuestion = function (model) {
        $rootScope.$emit("swConfirmDelete",
            {
                function() {
                    $scope.SubQuestion = model;
                    $http.post("/common/common.asmx/deleteQuestion", { QuestionID: $scope.SubQuestion.QuestionID }).then(function (Result) {
                        if (Result.data == true) {
                            $scope.getSubQuestionByQuestionID();
                        }
                        else
                            $rootScope.$emit("swAlertError", {});

                    }, function () {
                        $rootScope.$emit("swAlertError", {});
                    });
                }
            });
    };
    //$scope.getSubQuestionAnswersBySubQuestionID = function () {
    //    $http.post("/common/common.asmx/getQuestionAnswersByQuestionID", { QuestionID: $scope.SubQuestion.QuestionID }).then(function (Result) {
    //        $scope.SubQuestionAnswers = Result.data;
    //    }, function () {
    //        $rootScope.$emit("swAlertError", {});
    //    });
    //}
    //$scope.AddSubQuestionAnswer = function () {
    //    if (!$scope.SubQuestion.QuestionID) {
    //        $scope.SubQuestion.ParentQuestionID = $scope.Question.QuestionID;
    //        $http.post("/common/common.asmx/SaveQuestion", { model: $scope.SubQuestion }).then(function (Result) {
    //            if (Result.data == true) {
    //                $scope.SubQuestion = Result.data;
    //                if ($scope.SubQuestionAnswer.EnName) {
    //                    $scope.SubQuestionAnswer.QuestionID = $scope.SubQuestion.QuestionID;
    //                    $http.post("/common/common.asmx/SaveAnswers", { model: $scope.SubQuestionAnswer }).then(function (Result) {
    //                        if (Result.data == true) {
    //                            $scope.getSubQuestionAnswersBySubQuestionID();
    //                            $scope.SubQuestionAnswer = {};
    //                        }
    //                        else
    //                            $rootScope.$emit("swAlertError", {});

    //                    }, function () {
    //                        $rootScope.$emit("swAlertError", {});
    //                    });
    //                }
    //            }
    //        });
    //    } else {
    //        if ($scope.QuestionAnswer.EnName) {
    //            $scope.QuestionAnswer.QuestionID = $scope.Question.QuestionID;
    //            $http.post("/common/common.asmx/SaveAnswers", { model: $scope.QuestionAnswer }).then(function (Result) {
    //                if (Result.data == true) {
    //                    //$rootScope.$emit("swAlertSave", {});
    //                    $scope.getQuestionAnswersByQuestionID();
    //                    $scope.QuestionAnswer = {};
    //                }
    //                else
    //                    $rootScope.$emit("swAlertError", {});

    //            }, function () {
    //                $rootScope.$emit("swAlertError", {});
    //            });
    //        }
    //    }
    //}

    /* Skip Logic & Branching */
    $scope.loadSkipLogicQuestions = function () {
        $http.post("/common/common.asmx/getSkipLogicQuestions", { SurveyID: $scope.Survey.SurveyID }).then(function (Result) {
            $scope.SkipLogicQuestions = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }
    $scope.loadBranchingQuestions = function () {
        $http.post("/common/common.asmx/getBranchingQuestions", { SurveyID: $scope.Survey.SurveyID }).then(function (Result) {
            $scope.BranchingQuestions = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }
    $scope.getBranchingRules = function () {
        $http.post("/common/common.asmx/getBranchingRules", { SurveyID: $scope.Survey.SurveyID }).then(function (Result) {
            $scope.BranchingQuestions = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }
    $scope.loadBranchingQuestionAnswers = function () {
        $http.post("/common/common.asmx/getQuestionAnswersByQuestionID", { QuestionID: $scope.BranchingQuestion.QuestionID }).then(function (Result) {
            $scope.BranchingQuestionAnswers = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }

    $scope.AddSkipLogic = function () {
        if ($scope.BranchingQuestion.QuestionID && $scope.BranchingQuestion.AnswerID && $scope.BranchingQuestion.SkipToQuestionID) {
            $http.post("/common/common.asmx/saveBranchingQuestion", { model: $scope.BranchingQuestion, toBranch: false }).then(function (Result) {
                if (Result.data == true) {
                    $scope.loadSkipLogicQuestions();
                    $scope.BranchingQuestion = {};
                }
                else
                    $rootScope.$emit("swAlertError", {});

            }, function () {
                $rootScope.$emit("swAlertError", {});
            });
        }
    }
    $scope.EditSkipLogic = function (model) {
        $scope.BranchingQuestion = model;
        $scope.loadBranchingQuestionAnswers();
    }
    $scope.DeleteSkipLogic = function (model) {
        $rootScope.$emit("swConfirmDelete",
            {
                function() {
                    $scope.BranchingQuestion = model;
                    $http.post("/common/common.asmx/deleteBranchingOrSkipLogic", { AnswerID: $scope.BranchingQuestion.AnswerID }).then(function (Result) {
                        if (Result.data == true) {
                            $scope.loadSkipLogicQuestions();
                            $scope.BranchingQuestion = {};
                        }
                        else
                            $rootScope.$emit("swAlertError", {});

                    }, function () {
                        $rootScope.$emit("swAlertError", {});
                    });
                }
            });
    }
    $scope.CancelSkipLogic = function () {
        $scope.BranchingQuestion = {};
    };

    $scope.AddBranchToSurvey = function () {
        if ($scope.BranchingQuestion.QuestionID && $scope.BranchingQuestion.AnswerID && $scope.BranchingQuestion.SkipToBranchID) {
            $http.post("/common/common.asmx/saveBranchingQuestion", { model: $scope.BranchingQuestion, toBranch: true }).then(function (Result) {
                if (Result.data == true) {
                    $scope.loadBranchingQuestions();
                    $scope.BranchingQuestion = {};
                }
                else
                    $rootScope.$emit("swAlertError", {});

            }, function () {
                $rootScope.$emit("swAlertError", {});
            });
        }
    }
    $scope.EditBranchSurvey = function (model) {
        $scope.BranchingQuestion = model;
        $scope.loadBranchingQuestionAnswers();
    }
    $scope.DeleteBranchSurvey = function (model) {
        $rootScope.$emit("swConfirmDelete",
            {
                function() {
                    $scope.BranchingQuestion = model;
                    $http.post("/common/common.asmx/deleteBranchingOrSkipLogic", { AnswerID: $scope.BranchingQuestion.AnswerID }).then(function (Result) {
                        if (Result.data == true) {
                            $scope.loadBranchingQuestions();
                            $scope.BranchingQuestion = {};
                        }
                        else
                            $rootScope.$emit("swAlertError", {});

                    }, function () {
                        $rootScope.$emit("swAlertError", {});
                    });
                }
            });
    }
    $scope.CancelBranchSurvey = function () {
        $scope.BranchingQuestion = {};
    };

    /* Question Branches */
    $scope.getAllQuestionBranchesBySurveyID = function () {
        $http.post("/common/common.asmx/getAllQuestionBranchesBySurveyID", { SurveyID: $scope.Survey.SurveyID }).then(function (Result) {
            $scope.QuestionBranches = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    };
    $scope.AddQuestionBranch = function () {
        if ($scope.QuestionBranch.EnName) {
            $scope.QuestionBranch.SureveyID = $scope.Survey.SurveyID;
            $http.post("/common/common.asmx/SaveBranch", { model: $scope.QuestionBranch }).then(function (Result) {
                if (Result.data == true) {
                    $scope.getAllQuestionBranchesBySurveyID();
                    $scope.QuestionBranch = {};
                }
                else
                    $rootScope.$emit("swAlertError", {});

            }, function () {
                $rootScope.$emit("swAlertError", {});
            });
        }
    }
    $scope.EditQuestionBranch = function (branchID) {
        $http.post("/common/common.asmx/getQuestionBranch", { BranchID: branchID }).then(function (Result) {
            $scope.QuestionBranch = Result.data;
            //HideMasterShowDetails("#Listsurveys", "#SurveyDetails");            
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });

    };
    $scope.DeleteQuestionBranch = function (branchID) {
        $rootScope.$emit("swConfirmDelete",
            {
                function() {
                    $http.post("/common/common.asmx/deleteQuestionBranch", { BranchID: branchID }).then(function (Result) {
                        if (Result.data == true) {
                            $rootScope.$emit("swAlertSave", {});//HideMasterShowDetails("#Listsurveys", "#SurveyDetails");            
                            $scope.getAllQuestionBranchesBySurveyID();
                        }
                        else
                            $rootScope.$emit("swAlertSorry", {});

                    }, function () {
                        $rootScope.$emit("swAlertError", {});
                    });
                }
            });


    };
    $scope.CancelQuestionBranch = function () {
        $scope.QuestionBranch = {};
    };

    /* Publish List */
    $scope.getAllPublishList = function () {
        $http.post("/common/common.asmx/getAllListBySurveyID", { SurveyID: $scope.Survey.SurveyID }).then(function (Result) {
            $scope.PublishList = Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    };
    $scope.AddMail = function () {
        if ($scope.Mail.MemberEmail) {
            $scope.Mail.SurveyID = $scope.Survey.SurveyID;
            $http.post("/common/common.asmx/SaveMail", { model: $scope.Mail }).then(function (Result) {
                if (Result.data == true) {
                    $scope.getAllPublishList();
                    $scope.Mail = {};
                }
                else
                    $rootScope.$emit("swAlertError", {});

            }, function () {
                $rootScope.$emit("swAlertError", {});
            });
        }
    }
    $scope.EditEmail = function (memberID) {
        $http.post("/common/common.asmx/getSurveyMember", { MemberID: memberID }).then(function (Result) {
            $scope.Mail = Result.data;
            //HideMasterShowDetails("#Listsurveys", "#SurveyDetails");            
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });

    };
    $scope.DeleteEMail = function (memberID) {
        $rootScope.$emit("swConfirmDelete",
            {
                function() {
                    $http.post("/common/common.asmx/deleteSurveyMember", { MemberID: memberID }).then(function (Result) {
                        if (Result.data == true) {
                            $rootScope.$emit("swAlertSave", {});//HideMasterShowDetails("#Listsurveys", "#SurveyDetails");            
                            $scope.getAllPublishList();
                        }
                        else
                            $rootScope.$emit("swAlertSorry", {});

                    }, function () {
                        $rootScope.$emit("swAlertError", {});
                    });
                }
            });


    };
    $scope.CancelEmail = function () {
        $scope.Mail = {};
    };
    $scope.SendEMail = function (memberID, surveyID) {

        $rootScope.$emit("swConfirmPublish",
            {
                function() {
                    $scope.PublishStatus.PublishingToMember = true;
                    $scope.PublishStatus.MemberID = memberID;
                    $http.post("/common/common.asmx/SendEmailForAMember", { memberID: memberID, surveyID: surveyID }).then(function (Result) {
                        // $scope.Mail = Result.data;
                        //HideMasterShowDetails("#Listsurveys", "#SurveyDetails");
                        $scope.PublishStatus.MemberID = 0;
                        $scope.PublishStatus.PublishingToMember = false;
                        if (Result.data == true) {
                            $rootScope.$emit("swAlertPublish", {});
                        }
                        else {
                            $rootScope.$emit("swAlertError", {});
                        }

                    }, function () {
                        $scope.PublishStatus.MemberID = 0;
                        $scope.PublishStatus.PublishingToMember = false;
                        $rootScope.$emit("swAlertError", {});
                    });
                }
            });


    };

    $scope.getAllDemographicWeights = function () {
        return $http.post("/common/common.asmx/getAllDemographicWeightsBySurveyID", { surveyId: $scope.Survey.SurveyID, companyID: $scope.Survey.CompanyID }).then(function (Result) {
            $scope.ConList = Result.data.ConList;
            $scope.GovList = Result.data.GovList;
            $scope.BranchList = Result.data.BranchList;
            $scope.DeptList = Result.data.DeptList;
            $scope.DivList = Result.data.DivList;
            $scope.AreaList = Result.data.AreaList;
            $scope.AgeList = Result.data.AgeList;
            $scope.LevelList = Result.data.LevelList;
            $scope.JobTitleList = Result.data.JobTitleList;
            $scope.GradeList = Result.data.GradeList;
            $scope.GenderList = Result.data.GenderList;

            return Result.data;
        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }

    $scope.SaveDemographic = function () {
        var _weights = {
            ConList: $scope.ConList,
            GovList: $scope.GovList,
            BranchList: $scope.BranchList,
            DeptList: $scope.DeptList,
            DivList: $scope.DivList,
            AreaList: $scope.AreaList,
            AgeList: $scope.AgeList,
            LevelList: $scope.LevelList,
            JobTitleList: $scope.JobTitleList,
            GradeList: $scope.GradeList,
            GenderList: $scope.GenderList
        };
        return $http.post("/common/common.asmx/saveAllDemographicWeightsBySurveyID", { surveyId: $scope.Survey.SurveyID, companyID: $scope.Survey.CompanyID, weights: _weights }).then(function (Result) {
            if (Result.data == true)
                $rootScope.$emit("swAlertSave", {});

        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }

    function escapeHtml(value) {
        return String(value || "")
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#39;");
    }

    function getDemographicInputValue(id) {
        var element = document.getElementById(id);
        return element ? $.trim(element.value || "") : "";
    }

    function getOptionalWeightValue() {
        return getDemographicInputValue("demographicWeight");
    }

    function buildInput(id, placeholder, type) {
        return '<input id="' + id + '" type="' + (type || "text") + '" class="swal2-input" placeholder="' + escapeHtml(placeholder) + '">';
    }

    function buildWeightInput() {
        return buildInput("demographicWeight", "Weight (optional)", "number");
    }

    function buildCountrySelect() {
        var options = ['<option value="">Select country</option>'];
        var countries = $scope.ConList || [];

        for (var i = 0; i < countries.length; i++) {
            options.push('<option value="' + escapeHtml(countries[i].CountryID) + '">' + escapeHtml(countries[i].EnName) + '</option>');
        }

        return '<select id="demographicCountryId" class="swal2-select">' + options.join("") + '</select>';
    }

    function getDemographicOptionId(type, item) {
        if (!item) {
            return 0;
        }

        switch (type) {
            case "country": return item.CountryID;
            case "state": return item.GovernrateID;
            case "branch": return item.BranchID;
            case "department": return item.DepartmentID;
            case "division": return item.DivisionID;
            case "area": return item.AreaID;
            case "age": return item.AgeGroupID;
            case "level": return item.LevelID;
            case "jobtitle": return item.JobTitleID;
            case "grade": return item.GradeID;
            case "gender": return item.GenderID;
            default: return 0;
        }
    }

    function applyDialogDefaults(type, item) {
        if (!item) {
            return;
        }

        $("#demographicEnName").val(item.EnName || item.NameEn || item.EnDisplayName || "");
        $("#demographicArName").val(item.ArName || item.NameAr || item.ArDisplayName || "");

        if (type === "state") {
            $("#demographicCountryId").val(String(item.CountryID || ""));
        }

        if (type === "age") {
            $("#demographicStartAge").val(item.StartAge);
            $("#demographicEndAge").val(item.EndAge);
        }
    }

    function getDemographicList(type) {
        switch (type) {
            case "country":
                return $scope.ConList;
            case "state":
                return $scope.GovList;
            case "branch":
                return $scope.BranchList;
            case "department":
                return $scope.DeptList;
            case "division":
                return $scope.DivList;
            case "area":
                return $scope.AreaList;
            case "age":
                return $scope.AgeList;
            case "level":
                return $scope.LevelList;
            case "jobtitle":
                return $scope.JobTitleList;
            case "grade":
                return $scope.GradeList;
            case "gender":
                return $scope.GenderList;
            default:
                return [];
        }
    }

    function matchesDemographicOption(type, item, model) {
        if (!item) {
            return false;
        }

        switch (type) {
            case "country":
                return item.EnName == model.EnName;
            case "state":
                return item.EnName == model.EnName && String(item.CountryID) == String(model.CountryID);
            case "branch":
                return item.NameEn == model.EnName;
            case "department":
                return item.EnName == model.EnName;
            case "division":
                return item.NameEn == model.EnName;
            case "area":
                return item.NameEn == model.EnName;
            case "age":
                var defaultAgeName = model.EnName ? model.EnName : (model.StartAge + " - " + model.EndAge);
                return item.EnDisplayName == defaultAgeName || (String(item.StartAge) == String(model.StartAge) && String(item.EndAge) == String(model.EndAge));
            case "level":
                return item.EnName == model.EnName;
            case "jobtitle":
                return item.EnName == model.EnName;
            case "grade":
                return item.EnName == model.EnName;
            case "gender":
                return item.NameEn == model.EnName;
            default:
                return false;
        }
    }

    function tryApplyNewDemographicWeight(type, model) {
        var weight = $.trim(model.Weight || "");
        if (!weight) {
            return false;
        }

        var list = getDemographicList(type) || [];
        for (var i = list.length - 1; i >= 0; i--) {
            if (matchesDemographicOption(type, list[i], model)) {
                list[i].Weight = weight;
                return true;
            }
        }

        return false;
    }

    function buildDemographicDialog(type, item) {
        var isEdit = !!item;
        var config = {
            title: (isEdit ? "Edit" : "Add") + " demographic option",
            html: buildInput("demographicEnName", "English name") +
                buildInput("demographicArName", "Arabic name (optional)"),
            validate: function () {
                var enName = getDemographicInputValue("demographicEnName");
                if (!enName) {
                    return "English name is required.";
                }

                return {
                    EnName: enName,
                    ArName: getDemographicInputValue("demographicArName")
                };
            },
            onOpen: function () {
                applyDialogDefaults(type, item);
            }
        };

        switch (type) {
            case "country":
                config.title = (isEdit ? "Edit country" : "Add country");
                config.html = buildInput("demographicEnName", "Country name") +
                    buildInput("demographicArName", "Arabic name (optional)");
                break;
            case "state":
                config.title = (isEdit ? "Edit state" : "Add state");
                config.html = buildCountrySelect() +
                    buildInput("demographicEnName", "State name") +
                    buildInput("demographicArName", "Arabic name (optional)");
                config.validate = function () {
                    var countryId = getDemographicInputValue("demographicCountryId");
                    var enName = getDemographicInputValue("demographicEnName");

                    if (!countryId) {
                        return "Country is required.";
                    }

                    if (!enName) {
                        return "State name is required.";
                    }

                    return {
                        CountryID: parseInt(countryId, 10),
                        EnName: enName,
                        ArName: getDemographicInputValue("demographicArName")
                    };
                };
                config.onOpen = function () {
                    applyDialogDefaults(type, item);
                };
                break;
            case "branch":
                config.title = (isEdit ? "Edit branch" : "Add branch");
                config.html = buildInput("demographicEnName", "Branch name") +
                    buildInput("demographicArName", "Arabic name (optional)");
                break;
            case "department":
                config.title = (isEdit ? "Edit department" : "Add department");
                config.html = buildInput("demographicEnName", "Department name") +
                    buildInput("demographicArName", "Arabic name (optional)");
                break;
            case "division":
                config.title = (isEdit ? "Edit division" : "Add division");
                config.html = buildInput("demographicEnName", "Division name") +
                    buildInput("demographicArName", "Arabic name (optional)");
                break;
            case "area":
                config.title = (isEdit ? "Edit area" : "Add area");
                config.html = buildInput("demographicEnName", "Area name") +
                    buildInput("demographicArName", "Arabic name (optional)");
                break;
            case "age":
                config.title = (isEdit ? "Edit age group" : "Add age group");
                config.html = buildInput("demographicStartAge", "Start age", "number") +
                    buildInput("demographicEndAge", "End age", "number") +
                    buildInput("demographicEnName", "Display name (optional)") +
                    buildInput("demographicArName", "Arabic name (optional)");
                config.validate = function () {
                    var startAge = getDemographicInputValue("demographicStartAge");
                    var endAge = getDemographicInputValue("demographicEndAge");
                    var parsedStart = parseInt(startAge, 10);
                    var parsedEnd = parseInt(endAge, 10);

                    if (startAge === "" || isNaN(parsedStart)) {
                        return "Start age is required.";
                    }

                    if (endAge === "" || isNaN(parsedEnd)) {
                        return "End age is required.";
                    }

                    if (parsedEnd < parsedStart) {
                        return "End age must be greater than or equal to start age.";
                    }

                    return {
                        StartAge: parsedStart,
                        EndAge: parsedEnd,
                        EnName: getDemographicInputValue("demographicEnName"),
                        ArName: getDemographicInputValue("demographicArName")
                    };
                };
                config.onOpen = function () {
                    applyDialogDefaults(type, item);
                };
                break;
            case "level":
                config.title = (isEdit ? "Edit level" : "Add level");
                config.html = buildInput("demographicEnName", "Level name") +
                    buildInput("demographicArName", "Arabic name (optional)");
                break;
            case "jobtitle":
                config.title = (isEdit ? "Edit job title" : "Add job title");
                config.html = buildInput("demographicEnName", "Job title") +
                    buildInput("demographicArName", "Arabic name (optional)");
                break;
            case "grade":
                config.title = (isEdit ? "Edit grade" : "Add grade");
                config.html = buildInput("demographicEnName", "Grade name") +
                    buildInput("demographicArName", "Arabic name (optional)");
                break;
            case "gender":
                config.title = (isEdit ? "Edit gender" : "Add gender");
                config.html = buildInput("demographicEnName", "Gender name") +
                    buildInput("demographicArName", "Arabic name (optional)");
                break;
        }

        return config;
    }

    $scope.AddDemographicOption = function (type) {
        if (type === "state" && (!$scope.ConList || $scope.ConList.length === 0)) {
            swal({
                title: "Add country first",
                text: "You need at least one country before adding a state.",
                type: "warning",
                confirmButtonText: "Ok !",
                confirmButtonColor: "#3598DC"
            });
            return;
        }

        var dialog = buildDemographicDialog(type);
        swal({
            title: dialog.title,
            html: dialog.html,
            showCancelButton: true,
            showLoaderOnConfirm: true,
            confirmButtonText: "Save",
            cancelButtonText: "Cancel",
            confirmButtonColor: "#3598DC",
            cancelButtonColor: "#BFBFBF",
            onOpen: dialog.onOpen,
            preConfirm: function () {
                return new Promise(function (resolve, reject) {
                    var model = dialog.validate();
                    if (typeof model === "string") {
                        reject(model);
                        return;
                    }

                    resolve(model);
                });
            }
        }).then(function (model) {
            if (!model) {
                return;
            }

            $http.post("/common/common.asmx/SaveDemographicOption", {
                type: type,
                companyID: $scope.Survey.CompanyID,
                model: model
            }).then(function (result) {
                if (result.data == true) {
                    $scope.getAllDemographicWeights().then(function () {
                        if (tryApplyNewDemographicWeight(type, model)) {
                            $scope.SaveDemographic();
                        }
                        else {
                            $rootScope.$emit("swAlertSave", {});
                        }
                    });
                }
                else {
                    $rootScope.$emit("swAlertError", {});
                }
            }, function () {
                $rootScope.$emit("swAlertError", {});
            });
        }, function () { });
    }

    $scope.EditDemographicOption = function (type, item) {
        var dialog = buildDemographicDialog(type, item);
        swal({
            title: dialog.title,
            html: dialog.html,
            showCancelButton: true,
            showLoaderOnConfirm: true,
            confirmButtonText: "Save",
            cancelButtonText: "Cancel",
            confirmButtonColor: "#3598DC",
            cancelButtonColor: "#BFBFBF",
            onOpen: dialog.onOpen,
            preConfirm: function () {
                return new Promise(function (resolve, reject) {
                    var model = dialog.validate();
                    if (typeof model === "string") {
                        reject(model);
                        return;
                    }

                    var optionId = getDemographicOptionId(type, item);
                    if (optionId) {
                        switch (type) {
                            case "country": model.CountryID = optionId; break;
                            case "state": model.GovernrateID = optionId; break;
                            case "branch": model.BranchID = optionId; break;
                            case "department": model.DepartmentID = optionId; break;
                            case "division": model.DivisionID = optionId; break;
                            case "area": model.AreaID = optionId; break;
                            case "age": model.AgeGroupID = optionId; break;
                            case "level": model.LevelID = optionId; break;
                            case "jobtitle": model.JobTitleID = optionId; break;
                            case "grade": model.GradeID = optionId; break;
                            case "gender": model.GenderID = optionId; break;
                        }
                    }

                    resolve(model);
                });
            }
        }).then(function (model) {
            if (!model) {
                return;
            }

            $http.post("/common/common.asmx/SaveDemographicOption", {
                type: type,
                companyID: $scope.Survey.CompanyID,
                model: model
            }).then(function (result) {
                if (result.data == true) {
                    $scope.getAllDemographicWeights();
                    $rootScope.$emit("swAlertSave", {});
                }
                else {
                    $rootScope.$emit("swAlertError", {});
                }
            }, function () {
                $rootScope.$emit("swAlertError", {});
            });
        }, function () { });
    };

    $scope.DeleteDemographicOption = function (type, item) {
        var optionId = getDemographicOptionId(type, item);
        if (!optionId) {
            return;
        }

        $rootScope.$emit("swConfirmDelete", {
            function() {
                $http.post("/common/common.asmx/DeleteDemographicOption", {
                    type: type,
                    optionId: optionId
                }).then(function (result) {
                    if (result.data == true) {
                        $scope.getAllDemographicWeights();
                        $rootScope.$emit("swAlertSave", {});
                    }
                    else {
                        $rootScope.$emit("swAlertSorry", {});
                    }
                }, function () {
                    $rootScope.$emit("swAlertError", {});
                });
            }
        });
    };

    /*Startup functions*/
    $scope.getAllSurveys();
    getAllCompanies();
    $scope.getAllQuestionTypes();
    $scope.getAllSurveyTypes();
    $scope.getAllBankQuestions();

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
    $rootScope.$on("swAlertPublish", function () {
        swal({
            title: 'Publish Done Successfully !',
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
    $rootScope.$on("swCustomConfirmDelete", function (event, rAction, Message) {
        swal({
            title: 'Delete Confirming',
            text: Message,
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#E35B5A',
            cancelButtonColor: '#BFBFBF',
            confirmButtonText: '<i class="fa fa-check"></i> Delete',
            cancelButtonText: 'Cancel <i class="fa fa-chevron-right"></i>'
        }).then(
            function () { rAction.function() })
    });
    $rootScope.$on("swConfirmPublish", function (event, rAction) {
        swal({
            title: 'Publish Confirming',
            text: "This process is irreversible",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#E35B5A',
            cancelButtonColor: '#BFBFBF',
            confirmButtonText: '<i class="fa fa-check"></i> Publish',
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
