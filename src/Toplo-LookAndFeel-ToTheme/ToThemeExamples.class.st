Class {
	#name : #ToThemeExamples,
	#superclass : #Object,
	#category : #'Toplo-LookAndFeel-ToTheme-Examples'
}

{ #category : #button }
ToThemeExamples class >> example_toButtonChangeThemeOnClickChangeSkinOnRightClick [

	| but space |
	space := OBlSpace new.
	
	but := ToButton skinType: #default.
	but labelText: 'Button'.
	
	but whenClickedDo: [
		space toTheme: (space toTheme class = ToThemeLight
			ifTrue: [but labelText: 'Dark Theme'. ToThemeDark new.  ]
			ifFalse: [but labelText: 'Light Theme'. ToThemeLight new. ]) 
	].
			
	but when: BlMouseDownEvent do: [ :event |
		event secondaryButtonPressed ifTrue: [
			but skinType: (but skinType = #primary
					 ifTrue: [ #default ]
					 ifFalse: [ #primary ]) 
		].
	].
			
	space addChild: but.
	space show
]

{ #category : #'see class side' }
ToThemeExamples >> seeClassSide [ 
]
