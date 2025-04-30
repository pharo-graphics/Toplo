Class {
	#name : #ToTabBarSelectionElement,
	#superclass : #ToListSelectionElement,
	#category : #'Toplo-Widget-Tag-Tab'
}

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
				     ifTrue: [ nodeBounds bottom ]
				     ifFalse: [ aPoint y - self measuredHeight ] ]
		ifFalse: [
			y := aPoint y.
			x := aListElement atStartSide
				     ifTrue: [ nodeBounds right ]
				     ifFalse: [ aPoint x - self measuredWidth ] ].
	^ x @ y
]

{ #category : #private }
ToTabBarSelectionElement >> sizeFrom: aPoint in: aListElement [

	aListElement isFlowable ifTrue: [ ^ aPoint ].
	^ aListElement isHorizontal
		  ifTrue: [ aPoint x @ 3 ]
		  ifFalse: [ 3 @ aPoint y ]
]
