Class {
	#name : #ToListInfiniteElementDresser,
	#superclass : #ToDresser,
	#instVars : [
		'scrolledHandler',
		'shortcuts',
		'doubleClickHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #testing }
ToListInfiniteElementDresser class >> isDeprecated [ 

	^ true
]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.

	"true ifTrue: [ ^ self ]."
	doubleClickHandler := BlEventHandler
		                      on: BlDoubleClickEvent
		                      do: [ :anEvent |
			                      anElement primarySelection
				                      dispatchStrongSelectionChangedTo: anElement ].
	scrolledHandler := BlEventHandler
		                   on: BlElementScrolledEvent
		                   do: [ self updateHoveredNodeIn: anElement ].

	anElement addEventHandler: doubleClickHandler.
	anElement addEventHandler: scrolledHandler.	
	
	anElement primarySelection whenModeChangedDo: [
		self uninstallShortInIn: anElement.
		self installShortInIn: anElement ].
	self installShortInIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> installShortInIn: anElement [

	shortcuts := anElement primarySelection shortcutsIn: anElement.
	shortcuts do: [ :s | anElement addShortcut: s ]
]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> uninstallEventListenersIn: anElement [

"true ifTrue: [ ^ self ]."
	anElement removeEventHandler: scrolledHandler.
	anElement removeEventHandler: doubleClickHandler.

	self uninstallShortInIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> uninstallShortInIn: anElement [

	shortcuts do: [ :s | anElement removeShortcut: s ].
	shortcuts := nil
]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> updateHoveredNodeIn: anElement [

	anElement spaceDo: [ :sp | sp mouseProcessor handleLastMouseMove ]
]
