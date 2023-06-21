Class {
	#name : #ToComboBoxHeadDresser,
	#superclass : #ToComboBoxBaseHeadDresser,
	#instVars : [
		'downShortcut',
		'headPlaceholderHandler',
		'listClosedHandler'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> arrowDownEvent: anEvent in: anElement [

	| wasOpened |
	wasOpened :=  comboBox isOpened.
	wasOpened ifFalse: [ comboBox popupEvent: anEvent ].
	anEvent consumed: false.
	comboBox listElement infinite fireEvent: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> arrowUpEvent: anEvent in: anElement [

	| wasOpened |
	wasOpened :=  comboBox isOpened.
	wasOpened ifFalse: [ ^ self ].
	anEvent consumed: false.
	comboBox listElement infinite fireEvent: anEvent
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> escapeEvent: anEvent in: anElement [

	comboBox isOpened ifFalse: [ ^ self ].
	comboBox close.
	anEvent consumed: true
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
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
ToComboBoxHeadDresser >> newArrowUpShortcutIn: anElement [

	^ BlShortcutWithAction new
		                combination: BlKeyCombination arrowUp;
		                action: [ :event | self arrowUpEvent: event in: anElement ];
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
ToComboBoxHeadDresser >> newPlaceholder: aPlaceholder in: anElement [

	anElement placeholder: aPlaceholder.
	comboBox selectedIndex isZero ifTrue: [ anElement noDataSelected ]
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
ToComboBoxHeadDresser >> uninstallEventListenersIn: anElement [

	mouseDownHandler ifNotNil: [ anElement removeEventHandler: mouseDownHandler ].
	mouseDownHandler := nil.

	super uninstallEventListenersIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> whenAdded: anElement [

	super whenAdded: anElement.
	comboBox selectedIndex isZero ifTrue: [ anElement noDataSelected ].
	headPlaceholderHandler := BlEventHandler
		                          on: ToComboBoxHeadPlaceholderChangeEvent
		                          do: [ :event |
		                          self
			                          newPlaceholder: event placeholder
			                          in: anElement ].
	"listClosedHandler := self newListClosedHandlerIn: anElement."
	"comboBox addEventHandler: listClosedHandler."
	comboBox addEventHandler: headPlaceholderHandler
]

{ #category : #'api - install/uninstall  hook' }
ToComboBoxHeadDresser >> whenRemoved: anElement [

	comboBox removeEventHandler: headPlaceholderHandler.
	"comboBox removeEventHandler: listClosedHandler."
	downShortcut := nil.
	listClosedHandler := nil.

	super whenRemoved: anElement
]
