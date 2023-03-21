Class {
	#name : #ToListDecorationUpdater,
	#superclass : #Object,
	#instVars : [
		'selectionHandler',
		'extentChangeHandler',
		'scrollHandler',
		'decorations'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListDecorationUpdater >> decorations [ 

	^ decorations
]

{ #category : #'infinite element changes' }
ToListDecorationUpdater >> extentChangedIn: anInfiniteElement [

	self updateDecorationsIn: anInfiniteElement
]

{ #category : #initialization }
ToListDecorationUpdater >> initialize [ 

	super initialize.
	decorations := OrderedCollection new
]

{ #category : #'api - install/uninstall  hook' }
ToListDecorationUpdater >> onInstalledIn: aListElement [

	selectionHandler := BlEventHandler on: ToInfiniteSelectionChangedEvent do: [ self selectionChangedIn: aListElement ].
	extentChangeHandler := BlEventHandler
		                       on: BlElementExtentChangedEvent
		                       do: [ :evt | 
		                       self extentChangedIn: aListElement ].

	scrollHandler := BlEventHandler
		                 on: BlElementScrolledEvent
		                 do: [ :evt | self scrollEventIn: aListElement ].

	aListElement addEventHandler: extentChangeHandler.
	aListElement infinite addEventHandler: selectionHandler.
	aListElement infinite addEventHandler: scrollHandler
]

{ #category : #'api - install/uninstall  hook' }
ToListDecorationUpdater >> onUninstalledIn: aListElement [

	aListElement removeEventHandler: extentChangeHandler.
	aListElement infinite removeEventHandler: selectionHandler.
	aListElement infinite removeEventHandler: scrollHandler

]

{ #category : #private }
ToListDecorationUpdater >> resetDecorations [

	| rems |
	rems := decorations copy.
	rems do: [ :r | 
		r removeFromParent.
		decorations remove: r ]
]

{ #category : #'infinite element changes' }
ToListDecorationUpdater >> scrollEventIn: anInfiniteElement [

	self updateDecorationsIn: anInfiniteElement
]

{ #category : #'infinite element changes' }
ToListDecorationUpdater >> selectionChangedIn: anInfiniteElement [

	self updateDecorationsIn: anInfiniteElement
]

{ #category : #'infinite element changes' }
ToListDecorationUpdater >> updateDecorationsIn: anEditorElement [

]
