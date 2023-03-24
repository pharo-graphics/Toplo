Class {
	#name : #ToListNodesDecorationElement,
	#superclass : #ToListDecorationElement,
	#instVars : [
		'nodes',
		'back'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #private }
ToListNodesDecorationElement >> computeBounds [
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

{ #category : #initialization }
ToListNodesDecorationElement >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 5
]

{ #category : #initialization }
ToListNodesDecorationElement >> defaultPadding [

	^ BlInsets all: 0
]

{ #category : #initialization }
ToListNodesDecorationElement >> initialize [ 

	super initialize.
	self padding: self defaultPadding
]

{ #category : #private }
ToListNodesDecorationElement >> nodeBounds: aNode [
	" compute local node bounds "

	| bnds |
	bnds := aNode bounds inSpace bounds.
	aNode globalBoundsToLocal: bnds.
	aNode localBoundsToParent: bnds.
	^ BlBounds origin: bnds origin + listElement padding topLeft corner: bnds corner + listElement padding topLeft
	"bnds expandBy: (BlInsets left: node margin left right: node margin right)."	
]

{ #category : #accessing }
ToListNodesDecorationElement >> nodes [

	^ nodes
]

{ #category : #accessing }
ToListNodesDecorationElement >> nodes: aCollection [

	nodes := aCollection.
	self computeBounds
]

{ #category : #private }
ToListNodesDecorationElement >> nodesDo: aBlock [

	self nodes ifNil: [ ^ self ].
	self nodes do: aBlock
]
