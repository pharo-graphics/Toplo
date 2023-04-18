Class {
	#name : #ToComboBoxHeadDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'addedToParentHandler',
		'removedFromParentHandler',
		'downShortcut',
		'selectedIndexHandler',
		'comboBox',
		'headPlaceholderHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	
	addedToParentHandler := BlEventHandler on: BlElementAddedToParentEvent do: [ self whenAddedToParent: anElement ].
	removedFromParentHandler := BlEventHandler on: BlElementRemovedFromParentEvent do: [ self whenRemovedFromParent: anElement ].
	anElement addEventHandler: addedToParentHandler.
	anElement addEventHandler: removedFromParentHandler.

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> newPlaceholder: aPlaceholder in: anElement [

	| idx |
	anElement placeholder: aPlaceholder.
	(idx := comboBox selectedIndex) ifNil: [ ^ self ].
	idx isZero ifTrue: [ anElement noDataSelected ]
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement second: ((ToImage inner: (Smalltalk ui icons iconNamed: #bottom)) hFitContent; yourself).
	anElement second margin: (BlInsets
			 top: 2
			 left: 5
			 bottom: 2
			 right: 4).
	anElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ]
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> selectedIndex: anIndex in: anElement [

	anIndex isZero ifTrue: [
		anElement noDataSelected.
		^ self ].
	anElement selectData: (comboBox presentedData at: anIndex)
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> selectedIndexChangedIn: anElement [

	self selectedIndex: comboBox selectedIndex in: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: addedToParentHandler.
	anElement removeEventHandler: removedFromParentHandler.
	mouseDownHandler ifNotNil: [ anElement removeEventHandler: mouseDownHandler ].
	addedToParentHandler := nil.
	removedFromParentHandler := nil.
	mouseDownHandler := nil
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> whenAddedToParent: anElement [

	comboBox := anElement parent.
	
	selectedIndexHandler := BlEventHandler on:  ToComboBoxSelectedIndexChangeEvent do: [ :event | self selectedIndexChangedIn: anElement ].
	headPlaceholderHandler := BlEventHandler on:  ToComboBoxHeadPlaceholderChangeEvent do: [ :event | self newPlaceholder: event placeholder in: anElement].
	mouseDownHandler := (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | comboBox requestFocus. comboBox popupOrCloseEvent: evt ]).

	anElement addEventHandler: mouseDownHandler.
	comboBox addEventHandler: selectedIndexHandler.
	comboBox addEventHandler: headPlaceholderHandler.
	

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> whenRemovedFromParent: anElement [

	comboBox removeEventHandler: selectedIndexHandler.
	comboBox removeEventHandler: headPlaceholderHandler.
	anElement removeEventHandler: mouseDownHandler.

	mouseDownHandler := nil.
	downShortcut := nil.
	comboBox := nil
]
