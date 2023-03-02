Class {
	#name : #ToComboBoxHeadDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'addedToParentHandler',
		'removedFromParentHandler',
		'downShortcut',
		'combo'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	addedToParentHandler := BlEventHandler on: BlElementAddedToParentEvent do: [ self whenAddedToParent: anElement ].
	removedFromParentHandler := BlEventHandler on: BlElementRemovedFromParentEvent do: [ self whenRemovedFromParent: anElement ].
	anElement addEventHandler: addedToParentHandler.
	anElement addEventHandler: removedFromParentHandler
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement addChild: (ToPairedElement new
			 hMatchParent;
			 beJustified;
			 second: (ToButton new icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom)));
			 yourself).
	anElement padding: (BlInsets
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

	combo := anElement parent.
	mouseDownHandler := (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | combo requestFocus. combo popupOrCloseEvent: evt ]).
	anElement addEventHandler: mouseDownHandler.
	downShortcut := BlShortcutWithAction new
			 combination: BlKeyCombination arrowDown ;
			 action: [ :event | event traceCr. combo popupEvent: event ];
			 name: 'Popup';
			 yourself.
	combo addShortcut: downShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> whenRemovedFromParent: anElement [

	anElement removeEventHandler: mouseDownHandler.
	combo removeShortcut: downShortcut.

	mouseDownHandler := nil.
	downShortcut := nil.
	combo := nil
]
