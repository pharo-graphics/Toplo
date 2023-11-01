Class {
	#name : 'ToThemeExamples',
	#superclass : 'Object',
	#category : 'Toplo-Theme-Examples',
	#package : 'Toplo-Theme-Examples'
}

{ #category : 'private' }
ToThemeExamples class >> createThemeMenuBar: aSpace [

	| bar themeMenu inspectMenu |
	bar := ToMenuBar new hMatchParent; vFitContent.
	bar addMenu: (themeMenu := ToMenu new labelText: 'Bee Theme').
	bar addMenu: (inspectMenu := ToMenu new labelText: 'Tools').
	
	"Theme menu"	
	"Button to switch between light and dark theme"
	themeMenu addItem: (ToMenuItem new label: (ToLabel text: 'Switch to light'); tooltipText: 'Change the current Bee Theme to Bee light Theme'; whenClickedDo: [ self switchTheme: (ToBeeLightTheme new) for: aSpace ]).
	themeMenu addItem: (ToMenuItem new label: (ToLabel text: 'Switch to dark'); tooltipText: 'Change the current Bee Theme to Bee dark Theme'; whenClickedDo: [ self switchTheme: (ToBeeDarkTheme new) for: aSpace ]).
	themeMenu addItem: (ToMenuItem new label: (ToLabel text: 'Randomize color'); tooltipText: 'Randomize the current bee theme primary color'; whenClickedDo: [ self randomizeBeeThemeColorFor: aSpace ]).
	
	"Inspect menu"
	inspectMenu addItem: (ToMenuItem new label: (ToLabel text: 'Inspect Space'); tooltipText: 'Inspect the BlSpace'; whenClickedDo: [ self inspectSpace: aSpace ]).
	inspectMenu addItem: (ToMenuItem new label: (ToLabel text: 'Inspect Theme'); tooltipText: 'Inspect the current theme'; whenClickedDo: [ self inspectSpaceToTheme: aSpace ]).
	inspectMenu addItem: (ToMenuItem new label: (ToLabel text: 'Style Sheet source'); tooltipText: 'Show the current style sheet source code'; whenClickedDo: [ self displaySpaceStyleSheet: aSpace ]).
	inspectMenu addItem: (ToMenuItem new label: (ToLabel text: 'Style Sheet values'); tooltipText: 'Show the current style sheet values'; whenClickedDo: [ self displaySpaceValueStyleSheet: aSpace ]).
	
	^ bar
]

{ #category : 'private - actions' }
ToThemeExamples class >> displaySpaceStyleSheet: aSpace [

	| presenter stream |
	aSpace ifNil:[ ^ self ].
	aSpace toTheme ifNil:[ ^ self ].
	
	"Display Theme styleSheet in a text presenter"
	presenter := SpTextPresenter new.
	stream := ReadWriteStream on: String new.
	
	"Build the style sheet detail"
	aSpace toTheme styleSheet ifNil:[ stream nextPutAll: 'This theme doesn''t manage a style sheet.' ] ifNotNil:[ :sheet | | rules |
		stream 
			nextPutAll: 'Style Sheet with '; nextPutAll: (sheet rawStyleRules size) asString; nextPutAll: ' rule(s)' ; cr;
			nextPutAll: '###'; cr.
			
		rules := sheet rawStyleRules.	
		
		rules do:[ :rule | 
			stream cr.
			rule printOnStyleSheet: stream.
			stream cr.	
		].
	].
	
	"Open the presenter"
	presenter text: stream contents.
	presenter open.
	presenter withWindowDo: [ :w | w title: 'Toplo Style Sheet details' ].
]

{ #category : 'private - actions' }
ToThemeExamples class >> displaySpaceValueStyleSheet: aSpace [

	| presenter stream |
	aSpace ifNil:[ ^ self ].
	aSpace toTheme ifNil:[ ^ self ].
	
	"Display Theme styleSheet in a text presenter"
	presenter := SpTextPresenter new.
	stream := ReadWriteStream on: String new.
	
	"Build the style sheet detail"
	aSpace toTheme styleSheet ifNil:[ stream nextPutAll: 'This theme doesn''t manage a style sheet.' ] ifNotNil:[ :sheet | | rules |
		stream 
			nextPutAll: 'Style Sheet with '; nextPutAll: (sheet rawStyleRules size) asString; nextPutAll: ' rule(s)' ; cr;
			nextPutAll: '###'; cr.
			
		rules := sheet rawStyleRules.	
		
		rules do:[ :rule | 
			stream cr.
			rule printOnStyleSheet: stream for: aSpace.
			stream cr.	
		].
	].
	
	"Open the presenter"
	presenter text: stream contents.
	presenter open.
	presenter withWindowDo: [ :w | w title: 'Toplo Style Sheet details' ].
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
	dashedButton withStamp: #dashed.
	box addChild: dashedButton.
	
	textButton := (ToButton id: #buttonD) labelText: 'Text Button'; tooltipText: 'I''m a button'.
	textButton withStamp: #text.
	box addChild: textButton.
	
	linkButton := (ToButton id: #buttonE) labelText: 'Link Button'; tooltipText: 'I''m a button'.
	linkButton withStamp: #link.
	box addChild: linkButton.
	space show
]

{ #category : 'examples - buttons' }
ToThemeExamples class >> example_buttons1 [

	| space primaryButton defaultButton |
	ToTheme cleanUp.
	space := BlSpace new.
	space root layout: BlLinearLayout new.

	"Configure default Theme"
	space toTheme: ToBeeLightTheme new.
	space
		position: 1000 @ 1000.
	"Create some buttons with different skins"
	primaryButton := (ToButton id: #buttonA)
		                 labelText: 'Primary Button';
		                 tooltipText: 'I''m a primary button'.
	primaryButton withStamp: #primary.
	space root addChild: primaryButton.
	defaultButton := (ToButton id: #buttonB)
		                 labelText: 'Default Button';
		                 tooltipText: 'I''m a default button'.
	space root addChild: defaultButton.
	space show
]

{ #category : 'private - actions' }
ToThemeExamples class >> inspectSpace: aSpace [

	aSpace ifNil:[ ^ self ].
	aSpace inspect
]

{ #category : 'private - actions' }
ToThemeExamples class >> inspectSpaceToTheme: aSpace [

	aSpace ifNil:[ ^ self ].
	aSpace toTheme inspect
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
	space root addChild: (ToElement id: #themeSandBox).
	
	"Configure default Theme"
	space root toTheme: ToBeeLightTheme new.
	
	space position: 100@100.	
	^ space
]

{ #category : 'private - actions' }
ToThemeExamples class >> randomizeBeeThemeColorFor: aSpace [

	| theme |
	aSpace ifNil:[ ^ self ].
	theme := aSpace toTheme copy.
	theme colorPrimary: Color random.
	
	aSpace toTheme: theme.
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
