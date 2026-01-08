Class {
	#name : #ToTabListSelectionElement,
	#superclass : #ToListSelectionElement,
	#instVars : [
		'breadth'
	],
	#category : #'Toplo-Widget-TabPane-TabList'
}

{ #category : #accessing }
ToTabListSelectionElement >> breadth [

	^ breadth
]

{ #category : #accessing }
ToTabListSelectionElement >> breadth: aNumber [

	breadth := aNumber
]

{ #category : #initialization }
ToTabListSelectionElement >> initialize [ 

	super initialize.
	breadth := 8
]

{ #category : #private }
ToTabListSelectionElement >> positionFrom: aPoint in: aListElement [

	| x y nodeContainer nodeBounds insets |
	aListElement toConfiguration isFlowable ifTrue: [
		^ super positionFrom: aPoint in: aListElement ].
	" compute the selection element to be over the parent track element "
	nodeContainer := self nodeContainer.
	insets := BlInsets all: 0.
	nodeContainer
		allParentsUpTo: aListElement
		do: [ :p | insets := insets + p padding ].
	nodeContainer space ifNil: [ ^ aPoint ].
	nodeBounds := nodeContainer measuredBounds.
	aListElement isHorizontal
		ifTrue: [
				x := aPoint x.
				y := aListElement atStartSide
					     ifTrue: [ nodeBounds bottom - (breadth / 2) + insets bottom ]
					     ifFalse: [
					     aPoint y - self measuredHeight - (breadth / 2) - insets top ] ]
		ifFalse: [
				y := aPoint y.
				x := aListElement atStartSide
					     ifTrue: [ nodeBounds right - (breadth / 2) + insets right ]
					     ifFalse: [
					     aPoint x - self measuredWidth - (breadth / 2) - insets left ] ].

	^ super positionFrom: x @ y in: aListElement
]

{ #category : #private }
ToTabListSelectionElement >> sizeFrom: aPoint in: aListElement [

	aListElement toConfiguration isFlowable ifTrue: [ ^ aPoint ].
	^ aListElement isHorizontal
		  ifTrue: [ aPoint x @ breadth ]
		  ifFalse: [ breadth @ aPoint y ]
]
