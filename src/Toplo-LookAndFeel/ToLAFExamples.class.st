Class {
	#name : #ToLAFExamples,
	#superclass : #Object,
	#category : #'Toplo-LookAndFeel-Examples'
}

{ #category : #button }
ToLAFExamples class >> example_ButtonSkins [

	| space button1 button2 button3 button4 button5 |
	space := OBlSpace new.
	space root layout: (BlLinearLayout horizontal cellSpacing: 10).
	
	button1 := ToButton skinType: #primary.
	button1 labelText: 'Primary button'.
	
	button2 := ToButton skinType: #default.
	button2 labelText: 'Default button'.
	
	button3 := ToButton skinType: #dashed.
	button3 labelText: 'Dashed button'.
	
	button4 := ToButton skinType: #text.
	button4 labelText: 'Text button'.
	
	button5 := ToButton skinType: #link.
	button5 labelText: 'Link button'.
			
	space addChild: button1.
	space addChild: button2.
	space addChild: button3.
	space addChild: button4.
	space addChild: button5.
	space show.

	^space
]

{ #category : #button }
ToLAFExamples class >> example_ButtonSkins_Dark [

	| space |
	space := self example_ButtonSkins.
	space toTheme: (space toTheme darkTheme).
	^ space
]

{ #category : #button }
ToLAFExamples class >> example_MoreButtonSkins [

	| space |
	space := OBlSpace new.
	space root layout: (BlFlowLayout horizontal).
	
	1 to: 100 do:[ :i | | button1 button2 button3 button4 button5 |
		button1 := ToButton skinType: #primary.
		button1 labelText: 'Primary button ', i asString.
	
		button2 := ToButton skinType: #default.
		button2 labelText: 'Default button ', i asString.
	
		button3 := ToButton skinType: #dashed.
		button3 labelText: 'Dashed button ', i asString.
	
		button4 := ToButton skinType: #text.
		button4 labelText: 'Text button ', i asString.
	
		button5 := ToButton skinType: #link.
		button5 labelText: 'Link button ', i asString.
		
		space addChild: button1.
		space addChild: button2.
		space addChild: button3.
		space addChild: button4.
		space addChild: button5.
	].
	
	space show.
	^space
]

{ #category : #button }
ToLAFExamples class >> example_MoreButtonSkins_Dark [

	| space |
	space := self example_MoreButtonSkins.
	space toTheme: (space toTheme darkTheme).
	^ space
]

{ #category : #'see class side' }
ToLAFExamples >> seeClassSide [ 
]
