Class {
	#name : #ToLAFExamples,
	#superclass : #Object,
	#category : #'Toplo-LookAndFeel-Examples'
}

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
