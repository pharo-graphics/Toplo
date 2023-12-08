Class {
	#name : 'ToThemeExamples',
	#superclass : 'Object',
	#classInstVars : [
		'primaryButton1'
	],
	#category : 'Toplo-Theme-Examples',
	#package : 'Toplo-Theme-Examples'
}

{ #category : 'private' }
ToThemeExamples class >> createThemeMenuBar: aSpace [

	| bar themeMenu inspectMenu  beeMenu |
	bar := ToMenuBar new hMatchParent; vFitContent.
	bar addMenu: (themeMenu := ToMenu new labelText: 'Theme').
	bar addMenu: (inspectMenu := ToMenu new labelText: 'Tools').
	
	"Theme menu"	
	"Button to switch between light and dark theme"
	themeMenu addItem: (beeMenu := ToMenu new labelText: 'Bee').
	
	beeMenu addItem: (ToMenuItem new label: (ToLabel text: 'Switch to Light'); tooltipText: 'Change the current Bee Theme to Bee light Theme'; whenClickedDo: [ self switchTheme: (ToBeeLightTheme new) for: aSpace ]).
	beeMenu addItem: (ToMenuItem new label: (ToLabel text: 'Switch to Dark'); tooltipText: 'Change the current Bee Theme to Bee dark Theme'; whenClickedDo: [ self switchTheme: (ToBeeDarkTheme new) for: aSpace ]).
	
	themeMenu addItem: (ToMenuItem new label: (ToLabel text: 'Raw'); whenClickedDo: [ self switchTheme: (ToRawTheme new) for: aSpace ]).
	themeMenu addItem: (ToMenuItem new label: (ToLabel text: 'Randomize color'); tooltipText: 'Randomize the current bee theme primary color'; whenClickedDo: [ self randomizePrimaryColorFor: aSpace ]).
	
	"Inspect menu"
	inspectMenu addItem: (ToMenuItem new label: (ToLabel text: 'Inspect Space'); tooltipText: 'Inspect the BlSpace'; whenClickedDo: [ self inspectSpace: aSpace ]).
	inspectMenu addItem: (ToMenuItem new label: (ToLabel text: 'Inspect Theme'); tooltipText: 'Inspect the current theme'; whenClickedDo: [ self inspectSpaceToTheme: aSpace ]).
	inspectMenu addItem: (ToMenuItem new label: (ToLabel text: 'CSS like Style Sheet'); tooltipText: 'Show the current style sheet source code'; whenClickedDo: [ self displaySpaceCSSLikeStyleSheet: aSpace ]).
	inspectMenu addItem: (ToMenuItem new label: (ToLabel text: 'Style Sheet'); tooltipText: 'Show the current style sheet source code'; whenClickedDo: [ self displaySpaceStyleSheet: aSpace ]).
	
	^ bar
]

{ #category : 'private - actions' }
ToThemeExamples class >> displaySpaceCSSLikeStyleSheet: aSpace [

	| presenter stream printer |
	aSpace ifNil: [ ^ self ].
	aSpace toTheme ifNil: [ ^ self ].

	"Display Theme styleSheet in a text presenter"
	presenter := SpTextPresenter new.
	stream := ReadWriteStream on: String new.

	"Build the style sheet detail"
	aSpace root skinManager styleSheet
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
			printer := ToStyleSheetCSSLikePrinter styleSheet: sheet.
			printer printStyleSheetCSSLikeOn: stream ].

	"Open the presenter"
	presenter text: stream contents.
	presenter open.
	presenter withWindowDo: [ :w | w title: 'Toplo Style Sheet details' ]
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
	aSpace root skinManager styleSheet
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
			printer := ToStyleSheetPrinter new.
			printer printStyleSheet: sheet on: stream ].

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

{ #category : 'examples - labels' }
ToThemeExamples class >> example_ToLabelWithHeadingSkin [

	| typeArr headingArr listElement themeSwitcher space |
	ToTheme cleanUp.
	space := BlSpace new.
	space toTheme: ToBeeLightTheme new.
	space root layout: (BlLinearLayout vertical cellSpacing: 10).
	themeSwitcher := ToCheckbox new
		                 labelText: 'Dark Theme';
		                 beLabelFirst.
	themeSwitcher defaultSkin: ToCheckboxSkin new.
	themeSwitcher when: ToCheckableChangedEvent do: [ :event |
		space toTheme: (themeSwitcher isChecked
				 ifTrue: [ ToBeeDarkTheme new ]
				 ifFalse: [ ToBeeLightTheme new ]) ].

	space root addChild: themeSwitcher.

	listElement := ToListElement new nodeBuilder: [ :node :holder |
		               | lab |
		               lab := holder data.
							lab removeFromParent.
		               lab hMatchParent.
		               node addChild: lab ].
	listElement background: Color transparent.
	typeArr := {
		           ('Default' -> #( #default )).
		           ('Danger' -> #( #danger )).
		           ('Secondary' -> #( #secondary )).
		           ('Success' -> #( #success )).
		           ('Warning' -> #( #warning )) }.
	headingArr := {
		              ('H0' -> #H0).
		              ('H1' -> #H1).
		              ('H2' -> #H2).
		              ('H3' -> #H3).
		              ('H4' -> #H4).
		              ('H5' -> #H5) }.

	typeArr do: [ :typeAssoc |
		headingArr do: [ :headingAssoc |
			| lab |
			lab := ToLabel new.
			lab addAllStamps: typeAssoc value.
			lab addStamp: headingAssoc value.
			lab text: typeAssoc key , ' ' , headingAssoc key.
			listElement data add: lab ] ].
	space root addChild: listElement.
	space show
]

{ #category : 'examples - buttons' }
ToThemeExamples class >> example_beeButtonsInRawPane [

	| space primaryButton2 pane c chb disachb |
	ToTheme cleanUp.
	space := BlSpace new.
	space root layout: BlLinearLayout new.
	space root layout beVertical.
	pane := ToPane vertical.
	pane padding: (BlInsets all: 15).
	pane layout cellSpacing: 5.
	pane border: Color lightGray.
	"pane localToTheme: ToRawTheme new."
	space toTheme: ToBeeLightTheme new.

	disachb := ToCheckbox new label: (ToLabel text: 'Disable all buttons').
	disachb defaultSkin: ToCheckboxSkin new.

	chb := ToCheckbox new label: (ToLabel text: 'Swith primary').
	chb defaultSkin: ToCheckboxSkin new.

	"Create some buttons with different skins"
	primaryButton1 := (ToButton id: #buttonA) labelText:
		                  'Change button 2 primary color'.
	"primaryButton1 withStamp: #primary."
	"darkStyleSheet := ToBeeStyleSheet new."
	primaryButton2 := (ToButton id: #buttonA) labelText: 'Button 2'.
	primaryButton2 inspect.
	primaryButton1 whenClickedDo: [
		c := Color random.
		primaryButton2 setToken: #'color-primary' -> c.
		primaryButton2 setTokenNamed: #'color-primary-pressed' value: c twiceDarker.
		primaryButton2 setTokenNamed: #'color-primary-hover' value: c twiceLighter ].
	
	chb when: ToCheckableCheckEvent do: [ :evt |
		(evt current)
			ifTrue: [ primaryButton2 addStamp: #primary ]
			ifFalse: [ primaryButton2 removeStamp: #primary ] ].
	chb checked: true.
	disachb when: ToCheckableCheckEvent do: [ :evt |
		(evt current)
			ifTrue: [ pane childrenDo: [ :child | child disable ] ]
			ifFalse: [ pane childrenDo: [ :child | child enable ] ] ].

	"primaryButton2 addAllTokenProperties: ToBeeDarkTheme defaultTokenProperties."
	"primaryButton2 withStamp: #primary."
	pane addChild: primaryButton1.
	pane addChild: chb.
	pane addChild: primaryButton2.
	space root addChild: disachb.
	space root addChild: pane.
	space show
]

{ #category : 'examples - buttons' }
ToThemeExamples class >> example_buttons [

	| space defaultButton box dashedButton textButton linkButton line1 line2 primaryButton |
	ToTheme cleanUp.
	space := self openThemeExampleSpace.
	box := self elementSandBoxFor: space.

	line1 := BlElement new
		         layout: (BlLinearLayout horizontal cellSpacing: 5);
		         padding: (BlInsets all: 5);
		         constraintsDo: [ :c |
			         c vertical fitContent.
			         c horizontal fitContent ].
	box addChild: line1.

	"Create some buttons with available skins"
	primaryButton1 := (ToButton id: #buttonA)
		                 labelText: 'Primary Button';
		                 tooltipText: 'I''m a button'.
	primaryButton1 addStamp: #primary.
	line1 addChild: primaryButton1.

	defaultButton := (ToButton id: #buttonB)
		                 labelText: 'Default Button';
		                 tooltipText: 'I''m a button'.
	line1 addChild: defaultButton.

	dashedButton := (ToButton id: #buttonC)
		                labelText: 'Dashed Button';
		                tooltipText: 'I''m a button'.
	dashedButton addStamp: #dashed.
	line1 addChild: dashedButton.

	textButton := (ToButton id: #buttonD)
		              labelText: 'Text Button';
		              tooltipText: 'I''m a button'.
	textButton addStamp: #text.
	line1 addChild: textButton.

	linkButton := (ToButton id: #buttonE)
		              labelText: 'Link Button';
		              tooltipText: 'I''m a button'.
	linkButton addStamp: #link.
	line1 addChild: linkButton.

	line2 := BlElement new
		         layout: (BlLinearLayout horizontal cellSpacing: 5);
		         padding: (BlInsets all: 5);
		         constraintsDo: [ :c |
			         c vertical fitContent.
			         c horizontal fitContent ].
	box addChild: line2.

	"Create some buttons with available skins - disable"
	primaryButton := (ToButton id: #buttonA)
		                 labelText: 'Primary Button';
		                 tooltipText: 'I''m a button';
		                 disable.
	primaryButton addStamp: #primary.
	line2 addChild: primaryButton.

	defaultButton := (ToButton id: #buttonB)
		                 labelText: 'Default Button';
		                 tooltipText: 'I''m a button';
		                 disable.
	line2 addChild: defaultButton.

	dashedButton := (ToButton id: #buttonC)
		                labelText: 'Dashed Button';
		                tooltipText: 'I''m a button';
		                disable.
	line2 addChild: dashedButton.

	textButton := (ToButton id: #buttonD)
		              labelText: 'Text Button';
		              tooltipText: 'I''m a button';
		              disable.
	line2 addChild: textButton.

	linkButton := (ToButton id: #buttonE)
		              labelText: 'Link Button';
		              tooltipText: 'I''m a button';
		              disable.
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
	defaultButton addStamp: #'primary'.
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
ToThemeExamples class >> randomizePrimaryColorFor: aSpace [

	| c |
	aSpace ifNil:[ ^ self ].
	c := Color random.
	aSpace root setTokenNamed: #'color-primary' value: c.
	aSpace root setTokenNamed: #'color-primary-pressed' value: c twiceDarker .
	aSpace root setTokenNamed: #'color-primary-hover' value: c twiceLighter
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
