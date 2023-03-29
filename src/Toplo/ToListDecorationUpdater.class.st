Class {
	#name : #ToListDecorationUpdater,
	#superclass : #Object,
	#instVars : [
		'extentChangeHandler',
		'scrollHandler',
		'decorations'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListDecorationUpdater >> decorationOn: aNode [

	self decorations do: [ :d |
		(d nodes includes: aNode) ifTrue: [ ^ d ] ].
	^ nil
]

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

	extentChangeHandler := BlEventHandler
		                       on: BlElementExtentChangedEvent
		                       do: [ :evt | self extentChangedIn: aListElement ].

	scrollHandler := BlEventHandler
		                 on: BlElementScrolledEvent
		                 do: [ :evt | self scrollEventIn: aListElement ].

	aListElement infinite addEventHandler: extentChangeHandler.
	aListElement infinite addEventHandler: scrollHandler.

]

{ #category : #'api - install/uninstall  hook' }
ToListDecorationUpdater >> onUninstalledIn: aListElement [

	aListElement infinite removeEventHandler: extentChangeHandler.
	aListElement infinite removeEventHandler: scrollHandler

]

{ #category : #private }
ToListDecorationUpdater >> resetDecorations [

	decorations do: #removeFromParent.
	decorations reset
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
ToListDecorationUpdater >> updateDecorationsIn: aListElement [

]
