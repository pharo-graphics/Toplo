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

	| first last top bottom |
	first := nodes first.
	last := nodes last.
	top := self boundsOfNode: first.
	bottom := first = last
		          ifTrue: [ top ]
		          ifFalse: [ self boundsOfNode: last ].
	^ self boundsFrom: (BlBounds origin: top origin corner: bottom corner)
]

{ #category : #private }
ToListSelectionElement >> boundsOfNode: aNode [
	" compute local node bounds "

	^ (aNode bounds inSpace inChild: listElement) bounds
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

	nodes := aCollection.
	self computeBounds
]

{ #category : #private }
ToListSelectionElement >> positionFrom: aPoint [

	^ aPoint
]

{ #category : #private }
ToListSelectionElement >> sizeFrom: aPoint [

	^ aPoint
]
