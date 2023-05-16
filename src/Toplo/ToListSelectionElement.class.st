Class {
	#name : #ToListSelectionElement,
	#superclass : #ToElement,
	#instVars : [
		'listElement',
		'nodes'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #private }
ToListSelectionElement >> computeBounds [
	" compute my bounds from my list of adjacent nodes. "

	| first last top bottom |
	first := nodes first.
	last := nodes last.
	top := self nodeBounds: first.
	bottom := first = last
		          ifTrue: [ top ]
		          ifFalse: [ self nodeBounds: last ].
	self bounds: (BlBounds origin: top origin corner: bottom corner)
]

{ #category : #accessing }
ToListSelectionElement >> defaultLayout [

	^ BlFrameLayout new
]

{ #category : #initialization }
ToListSelectionElement >> initialize [ 

	super initialize.
	self layout: self defaultLayout.
	self geometry: self defaultGeometry.
	self background: Color transparent.
	self constraintsDo: [ :c | c ignoreByLayout ].
	self outskirts: BlOutskirts inside

]

{ #category : #accessing }
ToListSelectionElement >> listElement [

	^ listElement
]

{ #category : #accessing }
ToListSelectionElement >> listElement: aListElement [

	listElement := aListElement
]

{ #category : #private }
ToListSelectionElement >> nodeBounds: aNode [
	" compute local node bounds "

	| bnds |
	bnds := aNode bounds inSpace bounds.
	aNode globalBoundsToLocal: bnds.
	aNode localBoundsToParent: bnds.
	^ BlBounds origin: bnds origin + listElement padding topLeft corner: bnds corner + listElement padding topLeft
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
ToListSelectionElement >> nodesDo: aBlock [

	self nodes ifNil: [ ^ self ].
	self nodes do: aBlock
]
