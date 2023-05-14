Class {
	#name : #ToComboBoxHeadDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'addedToParentHandler',
		'removedFromParentHandler',
		'downShortcut',
		'selectedIndexHandler',
		'comboBox',
		'headPlaceholderHandler',
		'listClosedHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> arrowDownEvent: anEvent in: anElement [

	| wasOpened |
	self listElementRequestFocus.
	wasOpened :=  comboBox isOpened.
	wasOpened ifFalse: [ comboBox popupEvent: anEvent ].
	comboBox listElement data ifEmpty: [ ^ self ].
	comboBox listElement selectedIndexes ifEmpty: [
		comboBox listElement selectIndex: 1.
		^ self ].
	wasOpened ifFalse: [ ^ self ].
	comboBox listElement selectIndex: (comboBox listElement selectedIndex + 1)
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> escapeEvent: anEvent in: anElement [

	comboBox isOpened ifFalse: [ ^ self ].
	comboBox closeEvent: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	
	addedToParentHandler := BlEventHandler on: BlElementAddedToParentEvent do: [ self whenAdded: anElement ].
	removedFromParentHandler := BlEventHandler on: BlElementRemovedFromParentEvent do: [ self whenRemoved: anElement ].
	anElement addEventHandler: addedToParentHandler.
	anElement addEventHandler: removedFromParentHandler.

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> listElementRequestFocus [

	comboBox listElementRequestFocus
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> newArrowDownShortcutIn: anElement [

	^ BlShortcutWithAction new
		                combination: BlKeyCombination arrowDown;
		                action: [ :event | self arrowDownEvent: event in: anElement ];
		                name: 'Popup';
		                yourself.
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> newEscapeShortcutIn: anElement [

	^ BlShortcutWithAction new
		                combination: BlKeyCombination escape;
		                action: [ :event | self escapeEvent: event in: anElement ];
		                name: 'Escape';
		                yourself.
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> newListClosedHandlerIn: anElement [

	^ BlEventHandler
		  on: ToWidgetWindowClosedEvent
		  do: [ :event | anElement requestFocus ]
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> newMouseDownHandlerIn: anElement [

	^ BlEventHandler
		  on: BlMouseDownEvent
		  do: [ :evt |
			  comboBox popupOrCloseEvent: evt.
			  self listElementRequestFocus ]
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
	anElement selectData: (comboBox data at: anIndex)
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
ToComboBoxHeadDresser >> whenAdded: anElement [

	comboBox := anElement parent.
	comboBox selectedIndex isZero ifTrue: [ anElement noDataSelected ].
	selectedIndexHandler := BlEventHandler on:  ToComboBoxSelectedIndexChangeEvent do: [ :event | self selectedIndexChangedIn: anElement ].
	headPlaceholderHandler := BlEventHandler on:  ToComboBoxHeadPlaceholderChangeEvent do: [ :event | self newPlaceholder: event placeholder in: anElement].
	mouseDownHandler := self newMouseDownHandlerIn: anElement.
	listClosedHandler := self newListClosedHandlerIn: anElement.		
	comboBox addEventHandler: listClosedHandler.

	anElement addEventFilter: mouseDownHandler.
	comboBox addEventHandler: selectedIndexHandler.
	comboBox addEventHandler: headPlaceholderHandler.
	

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> whenRemoved: anElement [

	comboBox removeEventHandler: selectedIndexHandler.
	comboBox removeEventHandler: headPlaceholderHandler.
	comboBox removeEventHandler: listClosedHandler.
	anElement removeEventHandler: mouseDownHandler.
	mouseDownHandler := nil.
	downShortcut := nil.
	comboBox := nil.
	listClosedHandler := nil
]
