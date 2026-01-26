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
            if (Result.status == 200) {
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
                       if (Result.status == 200) {
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
            $rootScope.$emit("swAlertSave", {});
            $scope.getAllSurveys();
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
            if (Result.status == 200) {
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
    $scope.UpdateQuestionsOrders = function () {        
        $http.post("/common/common.asmx/UpdateQuestionsOrders", { model: $scope.Questions }).then(function (Result) {
            if (Result.status == 200) {
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
                        if (Result.status == 200) {
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
                if (Result.status == 200) {
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
            if (Result.status == 200) {
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
    //            if (Result.status == 200) {
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
                       $rootScope.$emit("swAlertPublish", {});

                   }, function () {
                       $scope.PublishStatus.MemberID = 0;
                       $scope.PublishStatus.PublishingToMember = false;
                       $rootScope.$emit("swAlertError", {});
                   });
               }
           });

        
    };

    $scope.getAllDemographicWeights = function () {
        $http.post("/common/common.asmx/getAllDemographicWeightsBySurveyID", { surveyId: $scope.Survey.SurveyID, companyID: $scope.Survey.CompanyID }).then(function (Result) {
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
            LevelList : $scope.LevelList,
            JobTitleList : $scope.JobTitleList ,
            GradeList : $scope.GradeList ,
            GenderList: $scope.GenderList
        };
        $http.post("/common/common.asmx/saveAllDemographicWeightsBySurveyID", { surveyId: $scope.Survey.SurveyID, companyID: $scope.Survey.CompanyID, weights: _weights }).then(function (Result) {
            if(Result.data == true)
                $rootScope.$emit("swAlertSave", {});

        }, function () {
            $rootScope.$emit("swAlertError", {});
        });
    }

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