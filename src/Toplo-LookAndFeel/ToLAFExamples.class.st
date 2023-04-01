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
	space show
]

{ #category : #button }
ToLAFExamples class >> example_toButtonChangeThemeOnClickChangeSkinOnRightClick [

	| but space |
	space := OBlSpace new.
	
	but := ToButton new.
	but dresser: ToLAFButtonDresser new.
	but labelText: 'Default Theme'.
	
	but whenClickedDo: [
		space toTheme: (space toTheme class = ToClearTheme
			ifTrue: [but labelText: 'Dark Theme'. ToDarkTheme new.  ]
			ifFalse: [but labelText: 'Clear Theme'. ToClearTheme new. ]) 
	].
			
	but when: BlMouseDownEvent do: [ :event |
		event secondaryButtonPressed ifTrue: [
			but skin: (but skin class = ToPrimaryButtonSkin
					 ifTrue: [ ToDefaultButtonSkin new ]
					 ifFalse: [ ToPrimaryButtonSkin new ]) 
		].
	].
			
	space addChild: but.
	space show
]

{ #category : #'see class side' }
ToLAFExamples >> seeClassSide [ 
]
