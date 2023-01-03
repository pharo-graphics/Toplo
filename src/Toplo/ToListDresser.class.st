Class {
	#name : #ToListDresser,
	#superclass : #ToDresser,
	#instVars : [
		'scrolledHandler',
		'selectNextShortcut',
		'selectPreviousShortcut',
		'focusGetterHandler',
		'focusHandler'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToListDresser >> defaultMargin [

	^ BlInsets all: 5
]

{ #category : #initialization }
ToListDresser >> defaultPadding [

	^ BlInsets all: 5
]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> installEventListenersIn: anElement [


	focusHandler := ToFocusHandler new.
	focusGetterHandler := BlEventHandler
		                   on: BlClickEvent do: [ :anEvent | anEvent currentTarget requestFocus ].
	scrolledHandler := BlEventHandler
		                   on: BlElementScrolledEvent
		                   do: [ self updateHoveredNodeIn: anElement ].
		
	anElement addEventHandler: scrolledHandler.
	anElement addEventHandler: focusHandler.
	anElement addEventHandler: focusGetterHandler.

	selectNextShortcut := BlShortcutWithAction new
		                      combination: BlKeyCombination builder arrowDown build;
		                      action: [ :aShortcutEvent :aShortcut | self selectNextIn: anElement event: aShortcutEvent ].
	selectPreviousShortcut := BlShortcutWithAction new
		                          combination: BlKeyCombination builder arrowUp build;
		                          action: [ :aShortcutEvent :aShortcut | self selectPreviousIn: anElement event: aShortcutEvent ].

	anElement addShortcut: selectNextShortcut.
	anElement addShortcut: selectPreviousShortcut
]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement padding: self defaultPadding.
	anElement margin: self defaultMargin.
	anElement clipChildren: true.
	anElement  geometry: (BlRoundedRectangleGeometry cornerRadius: 8).
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
					 width: 2) ].

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
ToListDresser >> selectNextIn: anElement event: aShortcutEvent [

	anElement selectionStrategy selectNextIn: anElement event: aShortcutEvent

]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> selectPreviousIn: anElement event: aShortcutEvent [

	anElement selectionStrategy selectPreviousIn: anElement event: aShortcutEvent
]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> uninstallEventListenersIn: anElement [

	anElement removeEventHandler: scrolledHandler.
	anElement removeEventHandler: focusHandler.
	anElement removeEventHandler: focusGetterHandler.
	anElement removeShortcut: selectNextShortcut.
	anElement removeShortcut: selectPreviousShortcut

]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> updateHoveredNodeIn: anElement [

	anElement space mouseProcessor handleLastMouseMove
]
