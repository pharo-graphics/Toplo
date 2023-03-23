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
		  ifTrue: [ self listElement selectedItemBackgroundColor ]
		  ifFalse: [ self listElement selectedItemBlurredBackgroundColor ]
]

{ #category : #accessing }
ToListSelectionDecorationElement >> adjacentNodes [

	^ adjacentNodes
]

{ #category : #accessing }
ToListSelectionDecorationElement >> adjacentNodes: aCollection [

	adjacentNodes := aCollection.
	self computeBounds
]

{ #category : #private }
ToListSelectionDecorationElement >> adjacentNodesDo: aBlock [

	self adjacentNodes ifNil: [ ^ self ].
	self adjacentNodes do: aBlock
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

	^ BlRoundedRectangleGeometry cornerRadius: 5
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

{ #category : #accessing }
ToListSelectionDecorationElement >> onAddedToParent [ 

	self background: self actualBackgroundColor.
	self adjacentNodesDo: [ :node | node dispatchEvent: (ToListSelectionDecorationAddedEvent new decoration: self; yourself) ].
	super onAddedToParent 
]

{ #category : #removing }
ToListSelectionDecorationElement >> onRemovedFromParent: aParentElement [

	super onRemovedFromParent: aParentElement.
	self adjacentNodesDo: [ :node | node dispatchEvent: (ToListSelectionDecorationRemovedEvent new decoration: self; yourself) ].

	

]

{ #category : #'change reporting' }
ToListSelectionDecorationElement >> updateBackground [ 

	listElement ifNil: [ ^ self ].
	super updateBackground.
	self adjacentNodesDo: [ :node | node dispatchEvent: (ToListSelectionDecorationChangedEvent new decoration: self; yourself) ].

]
