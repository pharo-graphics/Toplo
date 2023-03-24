Class {
	#name : #ToListInfiniteElementDresser,
	#superclass : #ToDresser,
	#instVars : [
		'scrolledHandler',
		'shortcuts',
		'doubleClickHandler',
		'menuPopupHandler',
		'menuCloseHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToListInfiniteElementDresser >> defaultMargin [

	^ BlInsets all: 0
]

{ #category : #initialization }
ToListInfiniteElementDresser >> defaultPadding [

	^ BlInsets all: 0
]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> installEventListenersIn: anElement [

	menuPopupHandler := BlEventHandler on: ToPopupWindowOpenedEvent do: [ :event | self popupOpenedEvent: event in: anElement ].
	menuCloseHandler := BlEventHandler on: ToPopupWindowClosedEvent do: [ :event | self popupClosedEvent: event in: anElement ].
	doubleClickHandler := BlEventHandler
		                      on: BlDoubleClickEvent
		                      do: [ :anEvent |
			                      anElement selectionStrategy
				                      dispatchStrongSelectionChangedTo: anElement ].
	scrolledHandler := BlEventHandler
		                   on: BlElementScrolledEvent
		                   do: [ self updateHoveredNodeIn: anElement ].

	anElement addEventHandler: doubleClickHandler.
	anElement addEventHandler: scrolledHandler.
	anElement addEventHandler: menuPopupHandler.
	anElement addEventHandler: menuCloseHandler.
	
	
	anElement selectionStrategy whenModeChangedDo: [
		self uninstallShortInIn: anElement.
		self installShortInIn: anElement ].
	self installShortInIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> installShortInIn: anElement [

	shortcuts := anElement selectionStrategy shortcutsIn: anElement.
	shortcuts do: [ :s | anElement addShortcut: s ]
]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	
	anElement outskirts: BlOutskirts outside.
	anElement padding: self defaultPadding.
	anElement margin: self defaultMargin.
	anElement clipChildren: true.
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

	anElement  border: (BlBorder
			 paint: anElement theme editor borderColor
			 width: 1).

	anElement background: Color transparent.
	
	self installEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> onUninstalledIn: anElement [

	self uninstallEventListenersIn: anElement.
	super onUninstalledIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> popupClosedEvent: anEvent in: anElement [

]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> popupOpenedEvent: anEvent in: anElement [


]

{ #category : #'api - install/uninstall  hook' }
ToListInfiniteElementDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: scrolledHandler.
	anElement removeEventHandler: doubleClickHandler.
	anElement removeEventHandler: menuPopupHandler.
	anElement removeEventHandler: menuCloseHandler.

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
