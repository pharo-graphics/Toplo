Class {
	#name : #ToListDresser,
	#superclass : #ToDresser,
	#instVars : [
		'scrolledHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> installEventListenersIn: anElement [

	scrolledHandler := BlEventHandler on:  BlElementScrolledEvent do: [ self updateHoveredNodeIn: anElement ].
	anElement addEventHandler: scrolledHandler.
]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self installEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> onUninstalledIn: anElement [

	self uninstallEventListenersIn: anElement.
	super onUninstalledIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: scrolledHandler 

]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> updateHoveredNodeIn: anElement [

	anElement space mouseProcessor handleLastMouseMove
]
