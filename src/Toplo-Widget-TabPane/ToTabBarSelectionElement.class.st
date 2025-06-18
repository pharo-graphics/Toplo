Class {
	#name : #ToTabBarSelectionElement,
	#superclass : #ToListSelectionElement,
	#instVars : [
		'breadth'
	],
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #accessing }
ToTabBarSelectionElement >> breadth [

	^ breadth
]

{ #category : #accessing }
ToTabBarSelectionElement >> breadth: aNumber [

	breadth := aNumber
]

{ #category : #initialization }
ToTabBarSelectionElement >> initialize [ 

	super initialize.
	breadth := 6
]

{ #category : #private }
ToTabBarSelectionElement >> positionFrom: aPoint in: aListElement [

	| x y node nodeBounds |
	aListElement isFlowable ifTrue: [ ^ aPoint ].
	" compute the selection element to be over the parent track element "
	node := self node.
	node space ifNil: [ ^ aPoint ].
	nodeBounds := node measuredBounds.
	aListElement isHorizontal
		ifTrue: [
			x := aPoint x.
			y := aListElement atStartSide
				     ifTrue: [ nodeBounds bottom - (breadth/2)]
				     ifFalse: [ aPoint y - self measuredHeight - (breadth/2)] ]
		ifFalse: [
			y := aPoint y.
			x := aListElement atStartSide
				     ifTrue: [ nodeBounds right - (breadth/2) ]
				     ifFalse: [ aPoint x - self measuredWidth - (breadth/2)] ].
	^ x @ y
]

{ #category : #private }
ToTabBarSelectionElement >> sizeFrom: aPoint in: aListElement [

	aListElement isFlowable ifTrue: [ ^ aPoint ].
	^ aListElement isHorizontal
		  ifTrue: [ aPoint x @ breadth ]
		  ifFalse: [ breadth @ aPoint y ]
]
