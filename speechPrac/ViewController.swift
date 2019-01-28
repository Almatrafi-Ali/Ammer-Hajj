//
//  ViewController.swift
//  speechPrac
//
//  Created by 정기웅 on 2018. 4. 11..
//  Copyright © 2018년 정기웅. All rights reserved.
//

import UIKit
import Speech
import Foundation

extension String { // حذف نص محدد حتى لو تكرر مناسب للمسافات
    
    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }
    
    func removeCharacters(from: String) -> String {
        return removeCharacters(from: CharacterSet(charactersIn: from))
    }
}

//====

extension String {
    
    func toLengthOf(length:Int) -> String {
        if length <= 0 {
            return self
        } else if let to = self.index(self.startIndex, offsetBy: length, limitedBy: self.endIndex) {
            return self.substring(from: to)
            
        } else {
            return ""
        }
    }
}
//===========================

class ViewController: UIViewController, SFSpeechRecognizerDelegate {

    var selectedText:String = "" // 2

    
    var nspeech1:String?
    var Ospeech2:String?
    
    var oldTextLength = 0
    var newTextLength = 0
    var didCount = false
    var didFoundInElse = false
    
    var useElse = "def"
    var oldCutText:String?
    var newCutText:String?
    
    var temp:String = " "
   
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var microphoneButton: UIButton!
    
    //arabic
     let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ar-SA"))
    //
     var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
     let audioEngine = AVAudioEngine()
     var recognitionTask: SFSpeechRecognitionTask?
     var c = 0
    var cHamdu = 0
    var cTkpeer = 0
    var cTasbeeh = 0
    var didRecord:Bool = false
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
        if segue.identifier == "showDetails" {
            let detail = segue.destination as! DetailController // 5
            // DetailController هو اسم الملف حق الفيو الثاني
            detail.detailText = selectedText // 7 هنا الربط ومجرى البيانات
            
        } else if segue.identifier == "arID" {
            let detail = segue.destination as! ARfile // 5
            // DetailController هو اسم الملف حق الفيو الثاني
            
        }
        /*
         if let identifier = segue.identifier {
         switch identifier {
         case "matchSegue":
         let controller = segue.destinationViewController as! ResultViewController
         controller.match = self.match
         case "historySegue":
         let controller = segue.destinationViewController as! HistoryViewController
         controller.history = self.history
         }
         }
         
         انت الان امام الكعبة المشرفة, يجب عليك اتمام ٧ اشواط, ابدأ بالطواف من الحجر الاسود
         عند بلوق الركن الياماني ابدا بالدعاء - ربنا آتني في الدنية حسنةوفي الاخيرة حسنة وقنا عذاب النار
         
         
       
         
         audioPlayer.play()

 */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        microphoneButton.isEnabled = false
        speechRecognizer?.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized :
                isButtonEnabled = true
            case .denied, .restricted, .notDetermined : isButtonEnabled = false
            }
            
            OperationQueue.main.addOperation {
                self.microphoneButton.isEnabled = isButtonEnabled
            }
        }
    //    nspeech1 = Ospeech2?.components(separatedBy: " ") // تقليص النص
        
        ///
    }

    func startRecording() {
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest.append(buffer)
        }

        do {
            audioEngine.prepare()
            try audioEngine.start()
        }
        catch {
            print("audio engine error")
        }
        recognitionRequest.shouldReportPartialResults = true
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest,
                                                            resultHandler: { (result, error) in
                                if let _result = result { /// if statement
                        
                        //  self.textView.text = _result.bestTranscription.formattedString
                self.nspeech1 = _result.bestTranscription.formattedString // ازالة المسافات
                self.nspeech1 =  self.nspeech1?.removeCharacters(from: " ")
                self.textView.text = self.nspeech1

                                    
                                    
                                    if self.didCount == false {

                                        self.nspeech1 = self.textView.text
                                   //     print(self.nspeech1!)
                                        if (self.nspeech1?.hasSuffix("طواف"))! { // true
                                            
                            self.selectedText = "انت الان امام الكعبة , يجب عليك اتمام ٧ اشواط"
self.performSegue(withIdentifier: "showDetails", sender: nil)
                            
                                        }
                                        
                                        if (self.nspeech1?.hasSuffix("الحمدلله"))! { // true
                                            self.cHamdu += 1
                                            print("فيه تطابق                    \(self.c)")
                                            self.didCount = true
                            //          self.hamdu.text = String(self.cHamdu)
                                            
                                        }
                                        
                                        if (self.nspeech1?.hasSuffix("اللهاكبر"))! { // true
                                            self.cTkpeer += 1
                                            print("فيه تطابق                    \(self.c)")
                                            self.didCount = true
                            //         self.tkbeer.text = String(self.cTkpeer)
                                            
                                        }
                                        
                                        
                                        if (self.nspeech1?.hasSuffix("سبحانالله"))! { // true
                                            self.cTasbeeh += 1
                                            print("فيه تطابق                    \(self.c)")
                                            self.didCount = true
                            //        self.Tasbeeh.text = String(self.cTasbeeh)
                                            
                                        }
                                        
                                        print("count 1: \(self.nspeech1!.count)")
                                        self.Ospeech2 = self.nspeech1
                                   //     self.didCount = true
                                        self.oldTextLength = (self.Ospeech2?.count)!
                                    } else {

                                    self.nspeech1 = self.textView.text?.toLengthOf(length: self.oldTextLength) //
                                        //       print(self.nspeech1!) ///
                                        self.temp = self.temp + self.nspeech1!
                                        print(self.temp)
                                      
                                        if (self.temp.hasSuffix("طواف")) { // true
                                            
                                            self.selectedText = "انت االان امام الكعبة يجب عليك اتمام ٧ اشواط"

                self.performSegue(withIdentifier: "showDetails", sender: nil)
                                        }
                                        
                                        if (self.temp.hasSuffix("الحمدلله")) { // true
                                            self.cHamdu += 1
                                            print("فيه تطابق                    \(self.c)")
                                            self.temp = " "
                                    //self.hamdu.text = String(self.cHamdu)
                                            
                                        }
                                        
                                        if (self.temp.hasSuffix("اللهاكبر")) { // true
                                            self.cTkpeer += 1
                                            print("فيه تطابق                    \(self.c)")
                                            self.temp = " "
                                            
                                        }
                                        
                                        if (self.temp.hasSuffix("سبحانالله")) { // true
                                            self.cTasbeeh += 1
                                            print("فيه تطابق                    \(self.c)")
                                            self.temp = " "
                                            
                                        }
                                        
                                        
                                        
                                        
                                print("count 2: \(self.nspeech1!.count + self.oldTextLength)   \(self.nspeech1!)")
                                        self.Ospeech2 = self.nspeech1! // append 2
                                        self.oldTextLength = self.nspeech1!.count + self.oldTextLength

                                        
                                   
                                        /* newTextLength = (texV.text?.count)! - oldTextLength
                                         speech = texV.text!.toLengthOf(length: newTextLength)
                                         texV.text = speech
                                         print("new Text length is: \(newTextLength)")
                                         print(texV.text!)
                                         
                                         oldTextLength = newTextLength
                                         */
                                    }


                                                                }
        })
    }

    
    
    
    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest.endAudio()
        recognitionTask?.cancel()
        recognitionTask = nil
    }

    @IBAction func microphoneTapped(_ sender: UIButton) {
        if audioEngine.isRunning {
            stopRecording()
            microphoneButton.setTitle(("تحدث"), for: .normal)
        }
        else {
            startRecording()
            microphoneButton.setTitle("توقف", for: .normal)
        }
    }
 
    @IBAction func btn(_ sender: Any) {
        self.performSegue(withIdentifier: "arID", sender: nil)

    }
    
}
