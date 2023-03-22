Class {
	#name : #ToListSelectionDecorationElement,
	#superclass : #ToListDecorationElement,
	#instVars : [
		'adjacentNodes'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListSelectionDecorationElement >> actualBackgroundColor [

	^ self listElement infinite isFocused
		  ifTrue: [ self listElement selectedItemBackground ]
		  ifFalse: [ self listElement blurSelectedItemBackground ]
]

{ #category : #accessing }
ToListSelectionDecorationElement >> adjacentNodes [

	^ adjacentNodes
]

{ #category : #accessing }
ToListSelectionDecorationElement >> adjacentNodes: aCollection [

	adjacentNodes := aCollection.
	self computeBounds.
	self background: self actualBackgroundColor.
	self changedSelectionBackground 
]

{ #category : #private }
ToListSelectionDecorationElement >> changedSelectionBackground [

	self adjacentNodes ifNil: [ ^ self ].
	self adjacentNodes do: [ :node | node addedInSelectionDecoration: self ]
]

{ #category : #removing }
ToListSelectionDecorationElement >> cleanUpNodes [

	self adjacentNodes do: [ :node | node removedFromSelectionDecoration: self ].


]

{ #category : #private }
ToListSelectionDecorationElement >> computeBounds [
	" compute my bounds from my list of adjacent nodes. "

	| first last top bottom |
	first := adjacentNodes first.
	last := adjacentNodes last.
	top := self nodeBounds: first.
	bottom := first = last
		          ifTrue: [ top ]
		          ifFalse: [ self nodeBounds: last ].
	self bounds: (BlBounds origin: top origin corner: bottom corner)
]

{ #category : #initialization }
ToListSelectionDecorationElement >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 6
]

{ #category : #private }
ToListSelectionDecorationElement >> nodeBounds: aNode [
	" compute local node bounds "

	| bnds |
	bnds := aNode bounds inSpace bounds.
	aNode globalBoundsToLocal: bnds.
	aNode localBoundsToParent: bnds.
	^ BlBounds origin: bnds origin + listElement padding topLeft corner: bnds corner + listElement padding topLeft
	"bnds expandBy: (BlInsets left: node margin left right: node margin right)."	
]

{ #category : #removing }
ToListSelectionDecorationElement >> removeFromParent [

	super removeFromParent.

]
