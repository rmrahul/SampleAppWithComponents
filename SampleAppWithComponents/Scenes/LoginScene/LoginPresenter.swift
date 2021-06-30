//
//  LoginPresenter.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 20/09/19.
//  Copyright (c) 2019 developer. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginPresentationLogic{
    func presentSomething(response: Login.Something.Response)
    func presentUI(response: Login.UI.Response)
    func presentValidationResult(response : Login.Validate.Response)
}

class LoginPresenter: LoginPresentationLogic{
    weak var viewController: LoginDisplayLogic?
    var validationWorker = ValidationWorker()

    struct strings  {
        var email = "Email address"
        var password =  "Password"
        var forgotPassword =  "Forgot password?"
        var signIn =  "Sign In"
        var clickableURLForgotPassword = "forgotPasswordURL"
        var clickableURLSignUp = "signUpURL"
        var signInOption =  "or sign in with"
        var gmail = "Gmail"
        var facebook = "Gmail"
        var signUp =  "Don't have an account? Sign Up Now"
    }
    
    private var stringFile = strings()
    
    // MARK: Do something
    
    func presentSomething(response: Login.Something.Response){
        let viewModel = Login.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentUI(response: Login.UI.Response){
        stringFile = strings()
        let cells = getCellConfig(types: response.uiComponenets)
        let viewModel = Login.UI.ViewModel(cellConfigs: cells)
        viewController?.displayUI(viewModel: viewModel)
    }
    
    func presentValidationResult(response: Login.Validate.Response) {
        
        let nosError = validationWorker.getValidationErrorMessage(validationResult: response.validationResultNameOfSubject)
        let genderError = validationWorker.getValidationErrorMessage(validationResult: response.validationResultGender)
        let contactError = validationWorker.getValidationErrorMessage(validationResult: response.validationResultContact)
        let religionError = validationWorker.getValidationErrorMessage(validationResult: response.validationResultReligion)
        let livingError = validationWorker.getValidationErrorMessage(validationResult: response.validationResultLiving)
        let educationError = validationWorker.getValidationErrorMessage(validationResult: response.validationResultEducation)
        let maritailStatusError = validationWorker.getValidationErrorMessage(validationResult: response.validationResultMaritialStatus)
        let occupationError = validationWorker.getValidationErrorMessage(validationResult: response.validationResultOccupation)

        let viewModel = Login.Validate.ViewModel(errorMessageForNameOfSubject: nosError, errorMessageForGender: genderError, errorMessageForContact: contactError, errorMessageForReligion: religionError, errorMessageForLiving: livingError, errorMessageForEducation: educationError, errorMessageForMaritialStatus: maritailStatusError, errorMessageForOccupation: occupationError)
        
        viewController?.displayValidationErrors(viewModel: viewModel)
    }
    private func getCellConfig(types : [Login.UIComponents]?) -> [(Login.UIComponents, BaseCellConfig)]?{
        stringFile = strings()
        
        guard let cellTypes = types else {
            return nil
        }
        
        var cells : [(Login.UIComponents, BaseCellConfig)] = []
        cellTypes.forEach { (type) in
            switch type {
            case .icon:
                var config = ImageTableViewCellConfig()
                config.backgroundColor = UIColor.clear
                config.image = UIImage(named: "logo")
                config.insets = UIEdgeInsets(top: 100, left: 20, bottom: 60, right: 20)
                config.size  = CGSize(width: 200, height: 200)
                cells.append((.icon, config))
            case .email:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]

                var config = TextfieldTableViewCellConfig()
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.placeHolder = stringFile.email
                config.backgroundColor = UIColor.clear
                config.title = NSAttributedString(string: stringFile.email, attributes: attributes)
                config.hideErrorIcon = false
                config.errorBackgrounColor = AppManager.appStyle.color(for: .errorBackgroud)
                cells.append((.email, config))
            case .password:
                var config = TextfieldTableViewCellConfig()
                config.placeHolder = stringFile.password
                config.backgroundColor = UIColor.clear
                config.insets = UIEdgeInsets(top: 50, left: 25, bottom: 10, right: 25)
                cells.append((.password, config))
            case .forgotpassword:
                var config = LabelTableViewCellConfig()
                config.insets = UIEdgeInsets(top: 5, left: 25, bottom: 10, right: 25)
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.appThemeColor,
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .subtitle)]
                
                config.labelText = NSAttributedString(string: stringFile.forgotPassword,attributes : attributes);
                config.alignment = NSTextAlignment.right
                config.backgroundColor = UIColor.clear
                let textRange = NSMakeRange(0, stringFile.forgotPassword.count)
                config.links = [(URL(string: stringFile.clickableURLForgotPassword),textRange)] as? [(URL, NSRange)]
                cells.append((.forgotpassword, config))
            case .signInbutton:
                var config = ButtonTableViewCellConfig()
                
                config.insets = UIEdgeInsets(top: 10, left: 200, bottom: 10, right: 200)
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .button),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .button)]
                
                config.buttonText = NSAttributedString(string: stringFile.signIn,attributes:attributes);
                config.background = UIImage(named: "buttonBackground")
                cells.append((.signInbutton, config))
            case .signInOption:
                var config = LabelTableViewCellConfig()
                config.insets = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .subtitle),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .subtitle)]
                
                config.labelText = NSAttributedString(string: stringFile.signInOption, attributes: attributes)
                config.alignment = NSTextAlignment.center
                cells.append((.signInOption, config))
            case .socialMedia:
                var config = ButtonTableViewCellConfig()
                config.insets = UIEdgeInsets(top: 10, left: 200, bottom: 10, right: 200)
                config.buttonText = NSAttributedString(string: "");
                config.background = UIImage(named: "gmailIcon")
                config.image = UIImage(named: "g")
                config.isNeedOfSecondaryButton = true
                config.secondaryButtonText = NSAttributedString(string: "");
                config.secondaryImage = UIImage(named: "f")
                config.secondaryButtonBackground = UIImage(named: "fbButtonBg")
                config.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 3, right: 0)
                config.secondaryContentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 3, right: 0)
                cells.append((.socialMedia, config))
            case .signUpOption:
                var config = LabelTableViewCellConfig()
                config.insets = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
                let attributes = [NSAttributedString.Key.foregroundColor : UIColor.black,
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                config.labelText = NSAttributedString(string: stringFile.signUp,attributes:attributes);
                config.alignment = NSTextAlignment.center
                config.backgroundColor = UIColor.clear
                let textRange = NSMakeRange(22, 12)
                config.links = [(URL(string: stringFile.clickableURLSignUp),textRange)] as? [(URL, NSRange)]
                cells.append((.signUpOption, config))
            case .multitextfields:
                
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                
                var configSerialNumber = TextfieldTableViewCellConfig()
                configSerialNumber.placeHolder = "Serial Number"
                configSerialNumber.text = "01"
                configSerialNumber.title = NSAttributedString(string: "Serial Number", attributes: attributes)
                configSerialNumber.enable = false
                configSerialNumber.backgroundColor = UIColor(hexString: "#DADADA")!
                
                
                var configSubjectId = TextfieldTableViewCellConfig()
                configSubjectId.placeHolder = "Serial Number"
                configSubjectId.text = "Aasdasasdas"
                configSubjectId.title = NSAttributedString(string: "Subject Id",attributes: attributes)
                configSubjectId.enable = false
                configSubjectId.backgroundColor = UIColor(hexString: "#DADADA")!
                
                var config = MultiTextfieldsTableViewCellConfig()
                config.textfields = [configSerialNumber, configSubjectId]
                config.backgroundColor = UIColor.lightGray
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.spacingBetweenTextfieilds = 20

                cells.append((.multitextfields, config))
            case .radioGroup:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]

                var config = RadioBoxGroupTableViewCellConfig()
                config.options = [NSAttributedString(string: "Subject Id",attributes: attributes),NSAttributedString(string: "Subject Id",attributes: attributes),NSAttributedString(string: "Subject Id",attributes: attributes)]
                config.title = NSAttributedString(string: "Religion",attributes: attributes)
                config.backgroundColor = UIColor.lightGray
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.spacing = 15
                config.numberOfColumn = 2
                config.spacingBetweenColumn = 20

                cells.append((.radioGroup, config))
            case .radioGroupOneColumn:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                
                var config = RadioBoxGroupTableViewCellConfig()
                config.options = [NSAttributedString(string: "Subject Id",attributes: attributes),NSAttributedString(string: "Subject Id",attributes: attributes),NSAttributedString(string: "Subject Id",attributes: attributes)]
                config.title = NSAttributedString(string: "Religion",attributes: attributes)
                config.backgroundColor = UIColor.lightGray
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.spacing = 15
                config.numberOfColumn = 1
                config.spacingBetweenColumn = 20
                config.hideInfo =  false
                
                cells.append((.radioGroupOneColumn, config))
            case .radioGroupWithOthers:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                
                var config = RadioBoxGroupTableViewCellConfig()
                config.options = [NSAttributedString(string: "Subject Id",attributes: attributes),NSAttributedString(string: "Subject Id",attributes: attributes),NSAttributedString(string: "Others",attributes: attributes)]
                config.title = NSAttributedString(string: "Religion",attributes: attributes)
                config.backgroundColor = UIColor.lightGray
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.spacing = 15
                config.numberOfColumn = 1
                config.spacingBetweenColumn = 20
                config.checkOthersOption = true
                
                cells.append((.radioGroupWithOthers, config))
                
                //Started orignal
            case .multiTextField:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                
                var configSerialNumber = TextfieldTableViewCellConfig()
                configSerialNumber.placeHolder = "Serial Number"
                configSerialNumber.text = "01"
                configSerialNumber.title = NSAttributedString(string: "Serial Number", attributes: attributes)
                configSerialNumber.enable = false
                configSerialNumber.backgroundColor = UIColor(hexString: "#DADADA")!
                
                
                var configSubjectId = TextfieldTableViewCellConfig()
                configSubjectId.placeHolder = "Serial Number"
                configSubjectId.text = "Aasdasasdas"
                configSubjectId.title = NSAttributedString(string: "Subject Id",attributes: attributes)
                configSubjectId.enable = false
                configSubjectId.backgroundColor = UIColor(hexString: "#DADADA")!
                
                var config = MultiTextfieldsTableViewCellConfig()
                config.textfields = [configSerialNumber, configSubjectId]
                config.backgroundColor = UIColor.lightGray
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.spacingBetweenTextfieilds = 20
                
                cells.append((.multiTextField, config))
            case .nameOfSubject:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                
                var config = TextfieldTableViewCellConfig()
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.placeHolder = "Name"
                config.backgroundColor = UIColor.clear
                config.title = NSAttributedString(string: "Name of Subject", attributes: attributes)
                config.hideErrorIcon = false
                config.errorBackgrounColor = AppManager.appStyle.color(for: .errorBackgroud)
                cells.append((.nameOfSubject, config))
                break
            case .age:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]

                var config = StepperTableViewCellConfig()
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.backgroundColor = UIColor.clear
                
                config.options = [NSAttributedString(string: "Year",attributes:     attributes), NSAttributedString(string: "Month",attributes:     attributes)]
                config.spacing = 15
                config.numberOfColumn = 2
                config.spacingBetweenColumn = 20
                
                config.hideErrorIcon = false
                config.errorBackgrounColor = AppManager.appStyle.color(for: .errorBackgroud)
                cells.append((.age, config))
            case .gender:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                
                var config = RadioBoxGroupTableViewCellConfig()
                config.title = NSAttributedString(string: "Gender",attributes: attributes)
                config.options = [NSAttributedString(string: "Male",attributes:     attributes),
                                  NSAttributedString(string: "Female",attributes: attributes),]

                config.backgroundColor = UIColor.lightGray
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.spacing = 15
                config.numberOfColumn = 2
                config.spacingBetweenColumn = 20
                
                config.hideErrorIcon = false
                config.errorBackgrounColor = AppManager.appStyle.color(for: .errorBackgroud)
                cells.append((.gender, config))
            case .address:
                break
            case .contact:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                
                var config = TextfieldTableViewCellConfig()
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.placeHolder = "Contact"
                config.backgroundColor = UIColor.clear
                config.title = NSAttributedString(string: "Contact Number", attributes: attributes)
                config.hideErrorIcon = false
                config.errorBackgrounColor = AppManager.appStyle.color(for: .errorBackgroud)
                cells.append((.contact, config))
            case .religion:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                
                var config = RadioBoxGroupTableViewCellConfig()
                 config.title = NSAttributedString(string: "Religion",attributes: attributes)
                config.options = [NSAttributedString(string: "Hindu",attributes: attributes),NSAttributedString(string: "Muslim",attributes: attributes),NSAttributedString(string: "Cristian",attributes: attributes),NSAttributedString(string: "Others",attributes: attributes)]
                
                config.backgroundColor = UIColor.lightGray
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.spacing = 15
                config.numberOfColumn = 2
                config.spacingBetweenColumn = 20
                config.checkOthersOption = true
                config.hideErrorIcon = false
                config.errorBackgrounColor = AppManager.appStyle.color(for: .errorBackgroud)
                
                cells.append((.religion, config))
            case .livingArrangement:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                
                var config = RadioBoxGroupTableViewCellConfig()
                config.title = NSAttributedString(string: "Living Arrangements",attributes: attributes)
                config.options = [NSAttributedString(string: "Living alone",attributes: attributes),NSAttributedString(string: "With Family",attributes: attributes),NSAttributedString(string: "With spouce",attributes: attributes),NSAttributedString(string: "With children",attributes: attributes)]
                
                config.backgroundColor = UIColor.lightGray
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.spacing = 15
                config.numberOfColumn = 2
                config.spacingBetweenColumn = 20
                config.checkOthersOption = false
                config.hideErrorIcon = false
                config.errorBackgrounColor = AppManager.appStyle.color(for: .errorBackgroud)
                cells.append((.livingArrangement, config))
            case .familyMembers:
                break
            case .educationStatus:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                
                var config = RadioBoxGroupTableViewCellConfig()
                config.title = NSAttributedString(string: "Educational Status",attributes: attributes)
                config.options = [NSAttributedString(string: "Illerate",attributes: attributes),NSAttributedString(string: "Primary",attributes: attributes),NSAttributedString(string: "Middle school",attributes: attributes),NSAttributedString(string: "High school",attributes: attributes),NSAttributedString(string: "intermediate",attributes: attributes),NSAttributedString(string: "Gradutate and above",attributes: attributes)]
                
                config.backgroundColor = UIColor.lightGray
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.spacing = 15
                config.numberOfColumn = 2
                config.spacingBetweenColumn = 20
                config.checkOthersOption = false
                
                config.hideErrorIcon = false
                config.errorBackgrounColor = AppManager.appStyle.color(for: .errorBackgroud)
                cells.append((.educationStatus, config))

            case .martialStatus:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                
                var config = RadioBoxGroupTableViewCellConfig()
                config.title = NSAttributedString(string: "Martial Status",attributes: attributes)
                config.options = [NSAttributedString(string: "Single",attributes: attributes),NSAttributedString(string: "Seperated",attributes: attributes),NSAttributedString(string: "Widow",attributes: attributes)]
                
                config.backgroundColor = UIColor.lightGray
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.spacing = 15
                config.numberOfColumn = 2
                config.spacingBetweenColumn = 20
                config.checkOthersOption = false
                
                config.hideErrorIcon = false
                config.errorBackgrounColor = AppManager.appStyle.color(for: .errorBackgroud)
                cells.append((.martialStatus, config))
            case .ocuupation:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                
                var config = RadioBoxGroupTableViewCellConfig()
                
                config.title = NSAttributedString(string: "Occupation",attributes: attributes)
                config.options = [NSAttributedString(string: "Currently Working",attributes: attributes),NSAttributedString(string: "Not working",attributes: attributes),NSAttributedString(string: "Retired",attributes: attributes),NSAttributedString(string: "Homemaker",attributes: attributes)]
                
                config.backgroundColor = UIColor.lightGray
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.spacing = 15
                config.numberOfColumn = 2
                config.spacingBetweenColumn = 20
                config.checkOthersOption = false
                
                config.hideErrorIcon = false
                config.errorBackgrounColor = AppManager.appStyle.color(for: .errorBackgroud)
                cells.append((.ocuupation, config))
            case .montlyIncome:
                break
            case .digosed:
                break
            case .treatmentStarted:
                break
            case .placeOfTreatment:
                break
            case .typeOfMedication:
                break
            case .numberOfTablet:
                break
            case .dosageOfOralDrugs:
                break
            case .dosageOfInsulin:
                break
            case .recentSuguar:
                let attributes = [NSAttributedString.Key.foregroundColor : AppManager.appStyle.color(for: .title),
                                  NSAttributedString.Key.font : AppManager.appStyle.font(for: .title)]
                
                var config = BloodSugarTableViewCellConfig()
                config.insets = UIEdgeInsets(top: 10, left: 160, bottom: 10, right: 160)
                config.backgroundColor = UIColor.clear
                config.title = NSAttributedString(string: "asdadasdasdas sd asdas", attributes: attributes)
                
                config.hideErrorIcon = false
                config.errorBackgrounColor = AppManager.appStyle.color(for: .errorBackgroud)
                cells.append((.recentSuguar, config))
            case .glycemicControl:
                break
            case .dibeticHistory:
                break
            case .coexistingIllness:
                break
            }
        }
        return cells;
    }
}
