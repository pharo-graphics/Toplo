Class {
	#name : #ToListSelectionElement,
	#superclass : #ToElement,
	#instVars : [
		'selectionOption',
		'nodes'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #accessing }
ToListSelectionElement >> boundsFrom: aBounds [

	^ aBounds
]

{ #category : #private }
ToListSelectionElement >> boundsFromNodesIn: aListElement [
	" compute my bounds from my list of adjacent nodes. "

	| first last startBnds endBnds corner |
	first := nodes first.
	last := nodes last.
	startBnds := self boundsOfNode: first in: aListElement.
	endBnds := first = last
		           ifTrue: [ startBnds ]
		           ifFalse: [ self boundsOfNode: last in: aListElement].
	(aListElement isVertical and: [
		 first constraints horizontal isMatchParent ])
		ifTrue: [
			| w |
			w := aListElement innerContainer bounds width.
			corner := w @ endBnds corner y ]
		ifFalse: [ corner := endBnds corner ].

	^ self boundsFrom: (BlBounds origin: startBnds origin corner: corner)
]

{ #category : #private }
ToListSelectionElement >> boundsOfNode: aNode in: aListElement [
	" compute local node bounds "
	^ (aNode measuredBounds inSpace inChild: aListElement innerContainer) bounds
]

{ #category : #private }
ToListSelectionElement >> computeBoundsIn: aListElement [
	" compute my bounds from my list of adjacent nodes. "

	| bnds |
	bnds := self boundsFromNodesIn: aListElement.
	self position: (self positionFrom: bnds origin in: aListElement).
	self size: (self sizeFrom: bnds extent in: aListElement)
]

{ #category : #initialization }
ToListSelectionElement >> initialize [

	super initialize.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self preventMouseEvents.
	self applySkinInstallerOnFirstRequest: true
]

{ #category : #accessing }
ToListSelectionElement >> nodes [

	^ nodes
]

{ #category : #accessing }
ToListSelectionElement >> nodes: aCollection [

	nodes := aCollection
]

{ #category : #private }
ToListSelectionElement >> positionFrom: aPoint in: aListElement [

	^ aPoint
]

{ #category : #accessing }
ToListSelectionElement >> selectionOption [

	^ selectionOption
]

{ #category : #accessing }
ToListSelectionElement >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption
]

{ #category : #private }
ToListSelectionElement >> sizeFrom: aPoint in: aListElement [

	^ aPoint
]
