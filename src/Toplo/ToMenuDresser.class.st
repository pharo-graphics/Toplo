Class {
	#name : #ToMenuDresser,
	#superclass : #ToGeneralButtonDresser,
	#instVars : [
		'addedToParentHandler',
		'removedFromParentHandler',
		'menuParent',
		'menuParentOverEventHandler'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> mouseOver: anEvent in: anElement [

	| win |
	win := anElement subMenuWindow ifNil: [ ^self ].
	(anEvent target hasAnyInParentChain: { win. anElement }) ifFalse: [ win close ]
]

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	addedToParentHandler := BlEventHandler on: BlElementAddedToParentEvent do: [ self whenAdded: anElement ].
	removedFromParentHandler := BlEventHandler on: BlElementRemovedFromParentEvent do: [ self whenRemoved: anElement ].
	anElement addEventHandler: addedToParentHandler.
	anElement addEventHandler: removedFromParentHandler.

	anElement fitContent
]

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement

]

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> whenAdded: anElement [

	menuParent := anElement parent.
	menuParentOverEventHandler := BlEventHandler
		                              on: BlMouseOverEvent
		                              do: [ :event | self mouseOver: event in: anElement ].
	menuParent addEventHandler: menuParentOverEventHandler
]

{ #category : #'api - install/uninstall  hook' }
ToMenuDresser >> whenRemoved: anElement [

	menuParent removeEventHandler: menuParentOverEventHandler.
	menuParent := nil.
	menuParentOverEventHandler := nil
]
