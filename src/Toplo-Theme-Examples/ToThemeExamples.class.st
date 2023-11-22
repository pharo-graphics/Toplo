Class {
	#name : 'ToThemeExamples',
	#superclass : 'Object',
	#category : 'Toplo-Theme-Examples',
	#package : 'Toplo-Theme-Examples'
}

{ #category : 'private' }
ToThemeExamples class >> createThemeMenuBar: aSpace [

	| bar themeMenu inspectMenu changeColorMenuItem beeMenu |
	bar := ToMenuBar new hMatchParent; vFitContent.
	bar addMenu: (themeMenu := ToMenu new labelText: 'Theme').
	bar addMenu: (inspectMenu := ToMenu new labelText: 'Tools').
	
	"Theme menu"	
	"Button to switch between light and dark theme"
	changeColorMenuItem := (ToMenuItem new label: (ToLabel text: 'Randomize color'); tooltipText: 'Randomize the current bee theme primary color'; whenClickedDo: [ self randomizeBeeThemeColorFor: aSpace ]).
	themeMenu addItem: (beeMenu := ToMenu new labelText: 'Bee').
	
	beeMenu addItem: (ToMenuItem new label: (ToLabel text: 'Switch to Light'); tooltipText: 'Change the current Bee Theme to Bee light Theme'; whenClickedDo: [ changeColorMenuItem enable. self switchTheme: (ToBeeLightTheme new) for: aSpace ]).
	beeMenu addItem: (ToMenuItem new label: (ToLabel text: 'Switch to Dark'); tooltipText: 'Change the current Bee Theme to Bee dark Theme'; whenClickedDo: [ changeColorMenuItem enable. self switchTheme: (ToBeeDarkTheme new) for: aSpace ]).
	beeMenu addItem: (changeColorMenuItem).
	
	themeMenu addItem: (ToMenuItem new label: (ToLabel text: 'Raw'); whenClickedDo: [ changeColorMenuItem disable. self switchTheme: (ToRawTheme new) for: aSpace ]).
		
	"Inspect menu"
	inspectMenu addItem: (ToMenuItem new label: (ToLabel text: 'Inspect Space'); tooltipText: 'Inspect the BlSpace'; whenClickedDo: [ self inspectSpace: aSpace ]).
	inspectMenu addItem: (ToMenuItem new label: (ToLabel text: 'Inspect Theme'); tooltipText: 'Inspect the current theme'; whenClickedDo: [ self inspectSpaceToTheme: aSpace ]).
	inspectMenu addItem: (ToMenuItem new label: (ToLabel text: 'Style Sheet source'); tooltipText: 'Show the current style sheet source code'; whenClickedDo: [ self displaySpaceStyleSheet: aSpace ]).
	
	^ bar
]

{ #category : 'private - actions' }
ToThemeExamples class >> displaySpaceStyleSheet: aSpace [

	| presenter stream printer |
	aSpace ifNil: [ ^ self ].
	aSpace toTheme ifNil: [ ^ self ].

	"Display Theme styleSheet in a text presenter"
	presenter := SpTextPresenter new.
	stream := ReadWriteStream on: String new.

	"Build the style sheet detail"
	aSpace toTheme styleSheet
		ifNil: [
		stream nextPutAll: 'This theme is not based on style sheets.' ]
		ifNotNil: [ :sheet |
			stream
				nextPutAll: 'CSS Like style sheet with ';
				nextPutAll: sheet rawStyleRules size asString;
				nextPutAll: ' rule(s)';
				cr;
				nextPutAll: '###';
				cr.
			printer := ToStyleSheetPrinter styleSheet: sheet.
			printer printStyleSheetCSSLikeOn: stream ].

	"Open the presenter"
	presenter text: stream contents.
	presenter open.
	presenter withWindowDo: [ :w | w title: 'Toplo Style Sheet details' ]
]

{ #category : 'private - get' }
ToThemeExamples class >> elementSandBoxFor: aSpace [

	| box |
	aSpace ifNil: [ ^ nil ].
	box := aSpace root childWithId: #themeSandBox.
	"Install default layout"
	box layout: BlFlowLayout vertical; padding: (BlInsets all: 5); constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal fitContent ].
	^ box
]

{ #category : 'examples - buttons' }
ToThemeExamples class >> example_beeButtonsInRawPane [

	| space primaryButton1 primaryButton2 pane |
	ToTheme cleanUp.
	space := BlSpace new.
	space root layout: BlLinearLayout new.

	pane := ToPane vertical.
	pane padding: (BlInsets all: 15).
	pane layout cellSpacing: 5.
	"pane localToTheme: ToRawTheme new."
	space toTheme: ToBeeLightTheme new.
	"Create some buttons with different skins"
	primaryButton1 := (ToButton id: #buttonA) labelText: 'Default Button Light Bee'.
	"primaryButton1 withStamp: #primary."
	primaryButton1 localToTheme: ToBeeLightTheme new.
	primaryButton2 := (ToButton id: #buttonA) labelText: 'Default Button Dark Bee'.
	"primaryButton2 withStamp: #primary."
	primaryButton2 localToTheme: ToBeeDarkTheme new.
	pane addChild: primaryButton1.
	pane addChild: primaryButton2.
	space root addChild: pane.
	space show
]

{ #category : 'examples - buttons' }
ToThemeExamples class >> example_buttons [

	| space primaryButton defaultButton box dashedButton textButton linkButton line1 line2 |
	ToTheme cleanUp.
	space := self openThemeExampleSpace.
	box := self elementSandBoxFor: space.
	
	line1 := BlElement new layout: (BlLinearLayout horizontal cellSpacing: 5); padding: (BlInsets all: 5); constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal fitContent ].
	box addChild: line1.

	"Create some buttons with available skins"
	primaryButton := (ToButton id: #buttonA) labelText: 'Primary Button'; tooltipText: 'I''m a button'.
	primaryButton withStamp: #primary.
	line1 addChild: primaryButton.

	defaultButton := (ToButton id: #buttonB) labelText: 'Default Button'; tooltipText: 'I''m a button'.
	line1 addChild: defaultButton.

	dashedButton := (ToButton id: #buttonC) labelText: 'Dashed Button'; tooltipText: 'I''m a button'.
	dashedButton withStamp: #dashed.
	line1 addChild: dashedButton.

	textButton := (ToButton id: #buttonD) labelText: 'Text Button'; tooltipText: 'I''m a button'.
	textButton withStamp: #text.
	line1 addChild: textButton.

	linkButton := (ToButton id: #buttonE) labelText: 'Link Button'; tooltipText: 'I''m a button'.
	linkButton withStamp: #link.
	line1 addChild: linkButton.
	
	line2 := BlElement new layout: (BlLinearLayout horizontal cellSpacing: 5); padding: (BlInsets all: 5); constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal fitContent ].
	box addChild: line2.

	"Create some buttons with available skins - disable"
	primaryButton := (ToButton id: #buttonA) labelText: 'Primary Button'; tooltipText: 'I''m a button'; disable.
	primaryButton withStamp: #primary.
	line2 addChild: primaryButton.

	defaultButton := (ToButton id: #buttonB) labelText: 'Default Button'; tooltipText: 'I''m a button'; disable.
	line2 addChild: defaultButton.

	dashedButton := (ToButton id: #buttonC) labelText: 'Dashed Button'; tooltipText: 'I''m a button'; disable.
	line2 addChild: dashedButton.

	textButton := (ToButton id: #buttonD) labelText: 'Text Button'; tooltipText: 'I''m a button'; disable.
	line2 addChild: textButton.

	linkButton := (ToButton id: #buttonE) labelText: 'Link Button'; tooltipText: 'I''m a button'; disable.
	line2 addChild: linkButton
]

{ #category : 'examples - buttons' }
ToThemeExamples class >> example_oneButton [

	| space defaultButton |
	ToTheme cleanUp.
	space := BlSpace new.
	space toTheme: ToBeeLightTheme new.
	defaultButton := ToButton new.
	"defaultButton when: ToElementLookEvent do: [ :evt | evt traceCr ]."
	defaultButton withStamp: #'primary'.
	defaultButton labelText: 'Default button'.
	space root addChild: defaultButton.
	space show.
	defaultButton inspect
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
	space root constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent ].

	"Create UI"
	space root addChild: (self createThemeMenuBar: space).
	space root addChild: (ToElement id: #themeSandBox).

	"Configure default Theme"
	space toTheme: ToBeeLightTheme new.

	space position: 100 @ 100.
	space show.
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
