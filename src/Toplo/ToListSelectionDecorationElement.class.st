Class {
	#name : #ToListSelectionDecorationElement,
	#superclass : #ToListDecorationElement,
	#instVars : [
		'adjacentNodes'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'as yet unclassified' }
ToListSelectionDecorationElement >> actualBackground [

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
	self background: self actualBackground.
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
	top := first bounds inSpace bounds.
	first globalBoundsToLocal: top.
	first localBoundsToParent: top.
	top expandBy: (BlInsets left: first margin left right: first margin right).
	first = last
		ifTrue: [ bottom := top ]
		ifFalse: [
			bottom := last bounds inSpace bounds.
			last globalBoundsToLocal: bottom.
			last localBoundsToParent: bottom.
			bottom expandBy: (BlInsets left: last margin left right: last margin right) ].

	self bounds: (BlBounds origin: top position corner: bottom corner)
]

{ #category : #removing }
ToListSelectionDecorationElement >> removeFromParent [

	super removeFromParent.

]
