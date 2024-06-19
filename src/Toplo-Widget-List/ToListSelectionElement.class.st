Class {
	#name : #ToListSelectionElement,
	#superclass : #ToElement,
	#instVars : [
		'listElement',
		'nodes'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #accessing }
ToListSelectionElement >> boundsFrom: aBounds [

	^ aBounds
]

{ #category : #private }
ToListSelectionElement >> boundsFromNodes [
	" compute my bounds from my list of adjacent nodes. "

	| first last startBnds endBnds corner |
	first := nodes first.
	last := nodes last.
	startBnds := self boundsOfNode: first.
	endBnds := first = last
		           ifTrue: [ startBnds ]
		           ifFalse: [ self boundsOfNode: last ].
	(listElement isVertical and: [
		 first constraints horizontal isMatchParent ])
		ifTrue: [
			| w |
			w := listElement innerContainer bounds width.
			corner := w @ endBnds corner y ]
		ifFalse: [ corner := endBnds corner ].

	^ self boundsFrom: (BlBounds origin: startBnds origin corner: corner)
]

{ #category : #private }
ToListSelectionElement >> boundsOfNode: aNode [
	" compute local node bounds "
	^ (aNode measuredBounds inSpace inChild: listElement innerContainer) bounds
]

{ #category : #private }
ToListSelectionElement >> computeBounds [
	" compute my bounds from my list of adjacent nodes. "

	| bnds |
	bnds := self boundsFromNodes.
	self position: (self positionFrom: bnds origin).
	self size: (self sizeFrom: bnds extent)
]

{ #category : #initialization }
ToListSelectionElement >> initialize [

	super initialize.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self preventMouseEvents.
	self applySkinInstallerOnFirstRequest: true
]

{ #category : #accessing }
ToListSelectionElement >> listElement [

	^ listElement
]

{ #category : #accessing }
ToListSelectionElement >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #accessing }
ToListSelectionElement >> nodes [

	^ nodes
]

{ #category : #accessing }
ToListSelectionElement >> nodes: aCollection [

	nodes := aCollection."
	self computeBounds"
]

{ #category : #private }
ToListSelectionElement >> positionFrom: aPoint [

	^ aPoint
]

{ #category : #private }
ToListSelectionElement >> positionFromNodes [
	" return my futur position from my list of adjacent nodes. "

	| bnds |
	bnds := self boundsFromNodes.
	^ self positionFrom: bnds origin
]

{ #category : #private }
ToListSelectionElement >> sizeFrom: aPoint [

	^ aPoint
]
