Class {
	#name : #ToListDresser,
	#superclass : #ToDresser,
	#instVars : [
		'scrolledHandler',
		'selectNextShortcut',
		'selectPreviousShortcut'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> installEventListenersIn: anElement [

	scrolledHandler := BlEventHandler
		                   on: BlElementScrolledEvent
		                   do: [ self updateHoveredNodeIn: anElement ].
		
	anElement addEventHandler: scrolledHandler.

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
	anElement removeShortcut: selectNextShortcut.
	anElement removeShortcut: selectPreviousShortcut

]

{ #category : #'api - install/uninstall  hook' }
ToListDresser >> updateHoveredNodeIn: anElement [

	anElement space mouseProcessor handleLastMouseMove
]
