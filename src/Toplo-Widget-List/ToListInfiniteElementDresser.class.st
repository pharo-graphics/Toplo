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

{ #category : #initialization }
ToListInfiniteElementDresser >> defaultMargin [

	^ BlInsets all: 0
]

{ #category : #initialization }
ToListInfiniteElementDresser >> defaultPadding [

	^ BlInsets all: 4
]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> installEventListenersIn: anElement [

	super installEventListenersIn: anElement.

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
ToListInfiniteElementDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement 
		when: BlBlurEvent
		do: [ :anEvent | 
			anElement  border: (BlBorder
					 paint: anElement theme editor borderColor
					 width: 1) ].
	anElement 
		when: BlFocusEvent
		do: [ :anEvent | 
			anElement border: (BlBorder
					 paint: anElement theme editor focusedBorderColor
					 width: 1) ].


]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> uninstallEventListenersIn: anElement [

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
