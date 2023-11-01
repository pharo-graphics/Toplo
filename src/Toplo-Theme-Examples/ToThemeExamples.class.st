Class {
	#name : 'ToThemeExamples',
	#superclass : 'Object',
	#category : 'Toplo-Theme-Examples',
	#package : 'Toplo-Theme-Examples'
}

{ #category : 'private' }
ToThemeExamples class >> createThemeMenuBar: aSpace [

	| menu |
	menu := ToMenu new.
	menu icon: (ToImage inner: (self iconNamed: #solidMenu)).
	
	"Button to switch between light and dark theme"
	menu addItem: (ToMenuItem new label: (ToLabel text: 'Bee Light'); tooltipText: 'Switch to Bee light theme'; whenClickedDo: [ self switchTheme: (ToBeeLightTheme new) for: aSpace ]).
	menu addItem: (ToMenuItem new label: (ToLabel text: 'Bee Dark'); tooltipText: 'Switch to Bee dark theme'; whenClickedDo: [ self switchTheme: (ToBeeDarkTheme new) for: aSpace ]).
	
	^ menu
]

{ #category : 'private - get' }
ToThemeExamples class >> elementSandBoxFor: aSpace [

	aSpace ifNil: [ ^ nil ].
	^ aSpace root childWithId: #themeSandBox
]

{ #category : 'examples - buttons' }
ToThemeExamples class >> example_buttons [

	| space primaryButton defaultButton box dashedButton textButton linkButton |
	space := self openThemeExampleSpace.
	box := self elementSandBoxFor: space.
	
	box 
		layout: BlFlowLayout horizontal; 
		padding: (BlInsets all: 5);
		constraintsDo: [ :c | c vertical matchParent. c horizontal matchParent ].
	
	"Create some buttons with different skins"
	primaryButton := (ToButton id: #buttonA) labelText: 'Primary Button'; tooltipText: 'I''m a button'.
	primaryButton withStamp: #primary.
	box addChild: primaryButton.
	
	defaultButton := (ToButton id: #buttonB) labelText: 'Default Button'; tooltipText: 'I''m a button'.
	box addChild: defaultButton.
	
	dashedButton := (ToButton id: #buttonC) labelText: 'Dashed Button'; tooltipText: 'I''m a button'.
	primaryButton withStamp: #dashed.
	box addChild: dashedButton.
	
	textButton := (ToButton id: #buttonD) labelText: 'Text Button'; tooltipText: 'I''m a button'.
	primaryButton withStamp: #text.
	box addChild: textButton.
	
	linkButton := (ToButton id: #buttonE) labelText: 'Link Button'; tooltipText: 'I''m a button'.
	primaryButton withStamp: #link.
	box addChild: linkButton.
]

{ #category : 'private' }
ToThemeExamples class >> openThemeExampleSpace [
	"Prepare a space to display theme examples"
	| space |
	space := BlSpace new.

	"Configure root layout"
	space root layout: BlFlowLayout vertical.
	space root constraintsDo: [ :c | c vertical matchParent. c horizontal matchParent ].
	
	"Create UI"
	space root addChild: (self createThemeMenuBar: space).
	space root addChild: (BlElement id: #themeSandBox).
	
	"Configure default Theme"
	space root toTheme: ToBeeLightTheme new.
	
	space position: 100@100; show.	
	^ space
]

{ #category : 'private - actions' }
ToThemeExamples class >> switchTheme: aToTheme for: aSpace [

	aSpace ifNil:[ ^ self ].
	aToTheme ifNil:[ ^ self ].
	
	aSpace toTheme: aToTheme.
]

{ #category : 'see class side' }
ToThemeExamples >> seeClassSide [ 
]
