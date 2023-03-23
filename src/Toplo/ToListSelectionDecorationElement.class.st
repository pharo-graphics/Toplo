Class {
	#name : #ToListSelectionDecorationElement,
	#superclass : #ToListDecorationElement,
	#instVars : [
		'nodes'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListSelectionDecorationElement >> actualBackgroundColor [

	^ self listElement infinite isFocused
		  ifTrue: [ self theme item selectedColor ]
		  ifFalse: [ self theme item selectedBlurredColor ]
]

{ #category : #private }
ToListSelectionDecorationElement >> computeBounds [
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
ToListSelectionDecorationElement >> defaultGeometry [

	^ BlRoundedRectangleGeometry cornerRadius: 5
]

{ #category : #initialization }
ToListSelectionDecorationElement >> defaultPadding [

	^ BlInsets all: 5
]

{ #category : #initialization }
ToListSelectionDecorationElement >> initialize [ 

	super initialize.
	self padding: self defaultPadding
]

{ #category : #accessing }
ToListSelectionDecorationElement >> listElement: aListElement [

	super listElement: aListElement.
	aListElement infinite when: BlBlurEvent do: [ :anEvent | self background: self actualBackgroundColor ].
	aListElement infinite when: BlFocusEvent do: [ :anEvent | self background: self actualBackgroundColor ]
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
ToListSelectionDecorationElement >> nodes [

	^ nodes
]

{ #category : #accessing }
ToListSelectionDecorationElement >> nodes: aCollection [

	nodes := aCollection.
	self computeBounds
]

{ #category : #private }
ToListSelectionDecorationElement >> nodesDo: aBlock [

	self nodes ifNil: [ ^ self ].
	self nodes do: aBlock
]

{ #category : #accessing }
ToListSelectionDecorationElement >> onAddedToParent [ 

	self background: self actualBackgroundColor.
	self nodesDo: [ :node | node dispatchEvent: (ToListSelectionDecorationAddedEvent new decoration: self; yourself) ].
	super onAddedToParent 
]

{ #category : #removing }
ToListSelectionDecorationElement >> onRemovedFromParent: aParentElement [

	super onRemovedFromParent: aParentElement.
	self nodesDo: [ :node | node dispatchEvent: (ToListSelectionDecorationRemovedEvent new decoration: self; yourself) ].

	

]

{ #category : #'change reporting' }
ToListSelectionDecorationElement >> updateBackground [ 

	listElement ifNil: [ ^ self ].
	super updateBackground.
	self nodesDo: [ :node | node dispatchEvent: (ToListSelectionDecorationChangedEvent new decoration: self; yourself) ].

]
