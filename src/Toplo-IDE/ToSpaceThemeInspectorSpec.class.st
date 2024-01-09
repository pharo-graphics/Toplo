Class {
	#name : #ToSpaceThemeInspectorSpec,
	#superclass : #SpPresenter,
	#instVars : [
		'space',
		'themeLabel',
		'themeChangedEventHandler',
		'browseClassButton',
		'elementSelector',
		'elementView'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #accessing }
ToSpaceThemeInspectorSpec >> browseClassButton [

	^ browseClassButton
]

{ #category : #layout }
ToSpaceThemeInspectorSpec >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: self browseClassButton expand: false;
				   add: self themeLabel expand: true;
				   yourself)
		  expand: false;
		  add: (SpPanedLayout newHorizontal add: self elementSelector ; add: self elementView; yourself)expand: true;
		  yourself
]

{ #category : #accessing }
ToSpaceThemeInspectorSpec >> elementSelector [

	^ elementSelector
]

{ #category : #'event handling' }
ToSpaceThemeInspectorSpec >> elementView [

	^ elementView
]

{ #category : #initialization }
ToSpaceThemeInspectorSpec >> initialize [

	super initialize.
	themeChangedEventHandler := BlEventHandler
		                            on: ToThemeChangedEvent
		                            do: [
			                            self updateSpace ]
]

{ #category : #initialization }
ToSpaceThemeInspectorSpec >> initializePresenters [

	elementView := ToSpaceThemeElementInspector new.
	elementSelector := ToSpaceThemeElementListSpec new
		                   whenSelectionChangedDo: [ :element |
			                   self selectionChanged: element ];
		                   yourself.
	themeLabel := SpLabelPresenter new
		              label: 'I need a space to display informations.';
		              yourself.
	browseClassButton := SpButtonPresenter new
		                     icon: (self iconNamed: #nautilus);
		                     label: 'Browse';
		                     help: 'Browse the theme of the space';
		                     yourself
]

{ #category : #'event handling' }
ToSpaceThemeInspectorSpec >> selectionChanged: aBlElement [

	self elementView element: aBlElement.
]

{ #category : #accessing }
ToSpaceThemeInspectorSpec >> space [

	^ space
]

{ #category : #accessing }
ToSpaceThemeInspectorSpec >> space: aBlSpace [

	space ifNotNil: [
		space root removeEventHandler: self themeChangedEventHandler ].
	space := aBlSpace.

	aBlSpace root addEventHandler: self themeChangedEventHandler.

	self updateSpace
]

{ #category : #accessing }
ToSpaceThemeInspectorSpec >> themeChangedEventHandler [

	^ themeChangedEventHandler
]

{ #category : #accessing }
ToSpaceThemeInspectorSpec >> themeLabel [

	^ themeLabel
]

{ #category : #accessing }
ToSpaceThemeInspectorSpec >> updateSpace [

	| strategy |
	strategy := self space userData
		            at: #toTheme
		            ifPresent: [ :theme |
			            theme spaceThemeStrategyFor: self ]
		            ifAbsent: [ ToSpaceThemeNoThemeStrategy new ].

	strategy applyOn: self.
	self elementSelector root: self space root
]
