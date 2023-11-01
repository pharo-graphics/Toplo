Class {
	#name : #ToThemeExamples,
	#superclass : #Object,
	#category : #'Toplo-Theme-Examples'
}

{ #category : #private }
ToThemeExamples class >> createThemeMenuBar: aSpace [

	| menu |
	menu := ToMenu new.
	menu icon: (ToImage inner: (self iconNamed: #solidMenu)).
	
	"Button to switch between light and dark theme"
	menu addItem: (ToMenuItem new label: (ToLabel text: 'Bee Light'); tooltipText: 'Switch to Bee light theme'; whenClickedDo: [ self switchTheme: (ToBeeLightTheme new) for: aSpace ]).
	menu addItem: (ToMenuItem new label: (ToLabel text: 'Bee Dark'); tooltipText: 'Switch to Bee dark theme'; whenClickedDo: [ self switchTheme: (ToBeeDarkTheme new) for: aSpace ]).
	
	^ menu
]

{ #category : #buttons }
ToThemeExamples class >> example_buttons [

	| space |
	space := self openThemeExampleSpace
]

{ #category : #private }
ToThemeExamples class >> openThemeExampleSpace [
	"Prepare a space to display theme examples"
	| space |
	space := BlSpace new.
	space root addChild: (self createThemeMenuBar: space).
	space position: 100@100; show.
	
	^ space
]

{ #category : #'private - actions' }
ToThemeExamples class >> switchTheme: aToTheme for: aSpace [

	aSpace ifNil:[ ^ self ].
	aToTheme ifNil:[ ^ self ].
	
	aSpace toTheme: aToTheme.
]

{ #category : #'see class side' }
ToThemeExamples >> seeClassSide [ 
]
