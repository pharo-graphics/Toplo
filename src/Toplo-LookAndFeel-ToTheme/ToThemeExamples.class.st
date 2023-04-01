Class {
	#name : #ToThemeExamples,
	#superclass : #Object,
	#category : #'Toplo-LookAndFeel-ToTheme-Examples'
}

{ #category : #button }
ToThemeExamples class >> example_toButtonChangeThemeOnClickChangeSkinOnRightClick [

	| but space |
	space := OBlSpace new.
	
	but := ToButton new.
	but dresser: ToLAFButtonDresser new.
	but labelText: 'Default Theme'.
	
	but whenClickedDo: [
		space toTheme: (space toTheme class = ToThemeLight
			ifTrue: [but labelText: 'Dark Theme'. ToThemeDark new.  ]
			ifFalse: [but labelText: 'Light Theme'. ToThemeLight new. ]) 
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
ToThemeExamples >> seeClassSide [ 
]
