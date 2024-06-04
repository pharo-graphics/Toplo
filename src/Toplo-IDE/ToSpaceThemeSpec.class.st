Class {
	#name : #ToSpaceThemeSpec,
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
ToSpaceThemeSpec >> browseClassButton [

	^ browseClassButton
]

{ #category : #layout }
ToSpaceThemeSpec >> defaultLayout [

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
ToSpaceThemeSpec >> elementSelector [

	^ elementSelector
]

{ #category : #'event handling' }
ToSpaceThemeSpec >> elementView [

	^ elementView
]

{ #category : #initialization }
ToSpaceThemeSpec >> initialize [

	super initialize.
	themeChangedEventHandler := BlEventHandler
		                            on: ToThemeInstalledEvent
		                            do: [
			                            self updateSpace ]
]

{ #category : #initialization }
ToSpaceThemeSpec >> initializePresenters [

	elementView := ToSpaceThemeElementViewPresenter new.
	elementSelector := ToSpaceThemeElementSelectorPresenter new
		                   whenSelectionChangedDo: [ :element |
			                   self selectionChanged: element ];
		                   columns: {
				                   ToSpaceThemeElementSelectorPresenter nameColumn.
				                   ToSpaceThemeElementSelectorPresenter
					                   tokenIconColumn.
				                   ToSpaceThemeElementSelectorPresenter
					                   rulesCountColumn.
				                   ToSpaceThemeElementSelectorPresenter
					                   stampsCountColumn.
				                   ToSpaceThemeElementSelectorPresenter
					                   visibilityColumn.
				                   ToSpaceThemeElementSelectorPresenter
					                   themeColumn };
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
ToSpaceThemeSpec >> selectionChanged: aBlElement [

	self elementView element: aBlElement.
]

{ #category : #accessing }
ToSpaceThemeSpec >> space [

	^ space
]

{ #category : #accessing }
ToSpaceThemeSpec >> space: aBlSpace [

	space ifNotNil: [
		space root removeEventHandler: self themeChangedEventHandler ].
	space := aBlSpace.
	aBlSpace root addEventHandler: self themeChangedEventHandler.
	self elementSelector root: self space root.
	self updateSpace
]

{ #category : #accessing }
ToSpaceThemeSpec >> themeChangedEventHandler [

	^ themeChangedEventHandler
]

{ #category : #accessing }
ToSpaceThemeSpec >> themeLabel [

	^ themeLabel
]

{ #category : #accessing }
ToSpaceThemeSpec >> updatePresenter [

	self elementSelector updatePresenter.
	self elementView updatePresenter.
]

{ #category : #accessing }
ToSpaceThemeSpec >> updateSpace [

	self space userData at: #toTheme ifPresent: [ :theme |
		self themeLabel label: 'I have a ' , theme name , ' installed.'.
		self browseClassButton enabled: true.
		self browseClassButton action: [ theme browse ].
		self updatePresenter ]
]
