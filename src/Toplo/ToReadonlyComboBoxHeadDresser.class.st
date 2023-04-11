Class {
	#name : #ToReadonlyComboBoxHeadDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'addedToParentHandler',
		'removedFromParentHandler',
		'downShortcut',
		'headElementFactoryHandler',
		'headPlaceholderChangeHandler',
		'selectedIndexHandler',
		'comboBox'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'api - install/uninstall  hook' }
ToReadonlyComboBoxHeadDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.
	
	addedToParentHandler := BlEventHandler on: BlElementAddedToParentEvent do: [ self whenAddedToParent: anElement ].
	removedFromParentHandler := BlEventHandler on: BlElementRemovedFromParentEvent do: [ self whenRemovedFromParent: anElement ].
	anElement addEventHandler: addedToParentHandler.
	anElement addEventHandler: removedFromParentHandler.

]

{ #category : #'api - install/uninstall  hook' }
ToReadonlyComboBoxHeadDresser >> newDataElementFactory: aFactory in: anElement [

	anElement dataElementFactory: aFactory.
	anElement showPlaceholder.
	comboBox selectedIndex isZero ifTrue: [ ^ self ].
	anElement hidePlaceholder.
	anElement data: (comboBox presentedData at: comboBox selectedIndex).
	comboBox listElement selectIndex: comboBox selectedIndex
]

{ #category : #'api - install/uninstall  hook' }
ToReadonlyComboBoxHeadDresser >> newPlaceholder: aPlaceholder in: anElement [

	anElement placeholder: aPlaceholder.
	comboBox selectedIndex ifNil: [ ^ self ].
	comboBox selectedIndex isZero ifTrue: [ anElement showPlaceholder ]
]

{ #category : #'api - install/uninstall  hook' }
ToReadonlyComboBoxHeadDresser >> onInstalledIn: anElement [

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
ToReadonlyComboBoxHeadDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToReadonlyComboBoxHeadDresser >> selectedIndexChangedIn: anElement [

	| idx |
	idx := comboBox selectedIndex.
	idx isZero ifTrue: [
		anElement showPlaceholder.
		^ self ].
	anElement hidePlaceholder.
	anElement data: (comboBox presentedData at: idx)
]

{ #category : #'api - install/uninstall  hook' }
ToReadonlyComboBoxHeadDresser >> uninstallEventListenersIn: anElement [

	super uninstallEventListenersIn: anElement.
	anElement removeEventHandler: addedToParentHandler.
	anElement removeEventHandler: removedFromParentHandler.
	mouseDownHandler ifNotNil: [ anElement removeEventHandler: mouseDownHandler ].
	addedToParentHandler := nil.
	removedFromParentHandler := nil.
	mouseDownHandler := nil
]

{ #category : #'api - install/uninstall  hook' }
ToReadonlyComboBoxHeadDresser >> whenAddedToParent: anElement [

	comboBox := anElement parent.
	
	headElementFactoryHandler := BlEventHandler on: ToComboBoxHeadElementFactoryChangeEvent do: [ :event | self newDataElementFactory: event factory in: anElement].
	headPlaceholderChangeHandler := BlEventHandler on:  ToComboBoxHeadPlaceholderChangeEvent do: [ :event | self newPlaceholder: event placeholder in: anElement].
	selectedIndexHandler := BlEventHandler on:  ToComboBoxSelectedIndexChangeEvent do: [ :event | self selectedIndexChangedIn: anElement ].
	comboBox addEventHandler: headElementFactoryHandler.
	comboBox addEventHandler: headPlaceholderChangeHandler.
	comboBox addEventHandler: selectedIndexHandler.

	mouseDownHandler := (BlEventHandler
			 on: BlMouseDownEvent
			 do: [ :evt | comboBox requestFocus. comboBox popupOrCloseEvent: evt ]).
	anElement addEventHandler: mouseDownHandler.
	downShortcut := BlShortcutWithAction new
			 combination: BlKeyCombination arrowDown ;
			 action: [ :event | comboBox popupEvent: event ];
			 name: 'Popup';
			 yourself.
	comboBox addShortcut: downShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToReadonlyComboBoxHeadDresser >> whenRemovedFromParent: anElement [

	anElement removeEventHandler: mouseDownHandler.
	comboBox removeEventHandler: headElementFactoryHandler.
	comboBox removeEventHandler: headPlaceholderChangeHandler.
	comboBox removeEventHandler: selectedIndexHandler.

	comboBox removeShortcut: downShortcut.

	mouseDownHandler := nil.
	downShortcut := nil.
	comboBox := nil
]
