//
//  JDTrumpQuotes.swift
//  Trump Punch
//
//  Created by Jared Downing on 1/23/16.
//  Copyright © 2016 Ideals. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class JDTrumpQuotes: SKMultilineLabel {
    
    var number = 0
    
    init(num: Int) {
        super.init(text: "", labelWidth: 250, pos: CGPointMake(0, 50))
        var choose = Int(arc4random_uniform(5))
        
        fontColor = UIColor.whiteColor()
        fontName = "Helvetica"
        fontSize = 18.0
        
        //DONALD TRUMP
        if num == 0 {
            choose = Int(arc4random_uniform(59))
            if choose == 0{
                text = "\"Listen you mother f****r, we're going to tax you 25 percent!\""
            }
            else if choose == 1{
                text = "\"You know, it really doesn't matter what [the media] write as long as you've got a young and beautiful piece of ass.\""
            }
            else if choose == 2{
                text = "\"When was the last time anybody saw us beating, let's say, China in a trade deal? They kill us. I beat China all the time. All the time. \""
            }
            else if choose == 3{
                text = "\"I will build a great wall, and nobody builds walls better than me, believe me.\""
            }
            else if choose == 4{
                text = "\"The wall will go up and Mexico will start behaving.\""
            }
            else if choose == 5{
                text = "\"Laziness is a trait in the blacks.\""
            }
            else if choose == 6{
                text = "\"If I were running 'The View,' I'd fire Rosie. I mean, I'd look her right in that fat, ugly face of hers, I'd say, 'Rosie, you're fired.' \""
            }
            else if choose == 7{
                text = "\"Hillary Clinton was the worst Secretary of State in the history of the United States\""
            }
            else if choose == 8{
                text = "\"If you can't get rich dealing with politicians, there's something wrong with you.\""
            }
            else if choose == 9{
                text = "\"All of the women on The Apprentice flirted with me, consciously or unconsciously. That's to be expected.\""
            }
            else if choose == 10{
                text = "\"One of the key problems today is that politics is such a disgrace. \""
            }
            else if choose == 11{
                text = "\"The beauty of me is that I'm very rich.\""
            }
            else if choose == 12{
                text = "\"It's freezing and snowing in New York we need global warming!\""
            }
            else if choose == 13{
                text = "\"I've said if Ivanka weren't my daughter, perhaps I'd be dating her\""
            }
            else if choose == 14{
                text = "\"My fingers are long and beautiful, as, it has been well documented, are various other parts of my body.\""
            }
            else if choose == 15{
                text = "\"I have never seen a thin person drinking Diet Coke.\""
            }
            else if choose == 16{
                text = "\"You're disgusting.\""
            }
            else if choose == 17{
                text = "\"The point is, you can never be too greedy. \""
            }
            else if choose == 18{
                text = "\"I have so many fabulous friends who happen to be gay, but I am a traditionalist. \""
            }
            else if choose == 19{
                text = "\"I'm the worst thing that's ever happened to Isis.\""
            }
            else if choose == 20{
                text = "\"The people who knocked down the World Trade Center, they didn't fly back to Sweden\""
            }
            else if choose == 21{
                text = "\"The Mexican government is much smarter, much sharper, and much mroe cunning.\""
            }
            else if choose == 22{
                text = "\"[Mexico is] sending people that have lots of problems, and theyr're bringing those problems with us. They're bringing drugs. They're bringing crime. They're rapists.\""
                pos = CGPointMake(0, 60)
            }
            else if choose == 23{
                text = "\"[on Carly Fiorina] Look at that face! Would anyone vote for that? Can you imagine that, the face of our next president?\""
            }
            else if choose == 24{
                text = "\"[Thoughts on an interviewer] You could see there was blood coming out of her eyes, blood coming out of her... whatever.\""
            }
            else if choose == 25{
                text = "\"[On Hillary Clinton losing to Obama] She was favored to win, and she got schlonged.\""
            }
            else if choose == 26{
                text = "\"Donald J. Trump is calling for a total and complete shutdown of Muslims entering the United States. [A press release]\""
            }
            else if choose == 27{
                text = "\"If I become president we're all going to be saying Merry Christmas again.\""
            }
            else if choose == 28{
                text = "\"I would never buy Ivana any decent jewels or pictures. Why give her negotiable assets?\""
            }
            else if choose == 29{
                text = "\"ISIS is using the Internet better than we are using the Internet, and it was our idea... I don't want them using our Internet.\""
            }
            else if choose == 30{
                text = "\"I just can't imagine hoo would be booing. \""
            }
            else if choose == 31{
                text = "\"We should be able to penetrate the Internet.\""
            }
            else if choose == 32{
                text = "\"It has not been easy for me. I started off in Brooklyn. My father gave me a small loan of a million dollars. \""
            }
            else if choose == 33{
                text = "\"We have nobody in Washington that sits back and said, you're not going to raise that f*****g price. \""
            }
            else if choose == 34{
                text = "\"No more massive injections. Tiny children are not horses - one vaccine at a time, over time. \""
            }
            else if choose == 35{
                text = "\"An 'extremely credible source' has called my office and told me that [Barack Obama's] certificate is a fraud.\""
            }
            else if choose == 36{
                text = "\"[In reference to Gaddafi] I don't want to use the word 'screwed,' but I screwed him.\""
            }
            else if choose == 37{
                text = "\"Dummy Bill Maher did an advertisment for the failing New York Times wehre the picture of him is very sad-he looks pathetic, bloated & gone! \""
            }
            else if choose == 38{
                text = "\"Rosie [O'Donnell] is crude, rude, obnoxious and dumb - other than that I like her very much!\""
            }
            else if choose == 39{
                text = "\"Our great African American President hasn't exactly had a positive impact on the thugs who are so happily and openly destroying Baltimore!\""
            }
            else if choose == 40{
                text = "\"[Arianna Huff] is unattractive both inside and out. I fully understand why her former husband left her for a man- he made a good decision. \""
            }
            else if choose == 41{
                text = "\"Stop the EBOLA patients from entering the U.S. Treat them, at the highest level, over there. THE UNITED STATES HAS ENOUGH PROBLEMS!\""
            }
            else if choose == 42{
                text = "\"While Bette Midler is an extremely unattractive woman, I refuse to say that because I always insist on being politically correct.\""
            }
            else if choose == 43{
                text = "\"I do not wear a rug. My hair is one hundred percent mine. \""
            }
            else if choose == 44{
                text = "\"I love beautiful women, and beautiful women love me. It has to be both ways.\""
            }
            else if choose == 45{
                text = "\"I have a great relationship with the blacks. I've always had a great relationship with the blacks. \""
            }
            else if choose == 46{
                text = "\"I think sometimes a black may think they don't have an advantage or this and that.. I believe they do have an actual advantage. \""
            }
            else if choose == 47{
                text = "\"I'm the least racist person there is. \""
            }
            else if choose == 48{
                text = "\"The concept of global warming was created by and for the Chinese in order to make U.S. manufacturing non-competitive.\""
            }
            else if choose == 49{
                text = "\"My Twitter has become so powerful that I can actually make my enemies tell the truth. \""
            }
            else if choose == 50{
                text = "\"This very expensive GLOBAL WARMING bulls**t has got to stop. Our planet is freezing, record low temps. \""
            }
            else if choose == 51{
                text = "\"Free trade is terrible. Free trade can be wonderful if you have smart people. But we have stupid people. \""
            }
            else if choose == 52{
                text = "\"Why is Obama playing basketball today? That is why our country is in trouble!\""
            }
            else if choose == 53{
                text = "\"How come every time I show anger, disgust or impatience, enemies say I had a tantrum or meltdown - stupid or dishonest people? \""
            }
            else if choose == 54{
                text = "\" Black guys counting my money! I hate it. \""
            }
            else if choose == 55{
                text = "\" Because president Obama has done such a poor job as president, you won't see another black president for generations! \""
            }
            else if choose == 56{
                text = "\"The second-greatest day of a man's life is the day he buys a yacht, but the greatest day of a man's life is the day he sells it. \""
            }
            else if choose == 57{
                text = "\"Sorry losers and hater, but my IQ is one of the highest - and you all know it! Please don't feel so stupid or insecure, it's not your fault.\""
            }
            else if choose == 58{
                text = "\" I think the only difference between me and the other candidates is that Im more honest and my women are more beautiful. \""
            }
           
            
        }
        
        
        
            
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setTo(num:Int) {
        self.number = num
        text = "\(self.number)"
    }
    
}
    