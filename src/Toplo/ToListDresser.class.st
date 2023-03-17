Class {
	#name : #ToListDresser,
	#superclass : #ToDresser,
	#instVars : [
		'scrolledHandler',
		'focusGetterHandler',
		'focusHandler',
		'shortcuts',
		'doubleClickHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToListDresser >> defaultMargin [

	^ BlInsets all: 1
]

{ #category : #initialization }
ToListDresser >> defaultPadding [

	^ BlInsets all: 1
]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> installEventListenersIn: anElement [

	focusHandler := ToFocusHandler new.
	focusGetterHandler := BlEventHandler
		                      on: BlClickEvent
		                      do: [ :anEvent | anElement requestFocus ].
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
	anElement addEventHandler: focusHandler.
	anElement addEventHandler: focusGetterHandler.

	anElement selectionStrategy whenModeChangedDo: [
		self uninstallShortInIn: anElement.
		self installShortInIn: anElement ].
	self installShortInIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> installShortInIn: anElement [

	shortcuts := anElement selectionStrategy shortcutsIn: anElement.
	shortcuts do: [ :s | anElement addShortcut: s ]
]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
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

	anElement background: Color white.
	
	self installEventListenersIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> onUninstalledIn: anElement [

	self uninstallEventListenersIn: anElement.
	super onUninstalledIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: scrolledHandler.
	anElement removeEventHandler: focusHandler.
	anElement removeEventHandler: focusGetterHandler.
	anElement removeEventHandler: doubleClickHandler.
	self uninstallShortInIn: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> uninstallShortInIn: anElement [

	shortcuts do: [ :s | anElement removeShortcut: s ].
	shortcuts := nil
]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> updateHoveredNodeIn: anElement [

	anElement spaceDo: [ :sp | sp mouseProcessor handleLastMouseMove ]
]
