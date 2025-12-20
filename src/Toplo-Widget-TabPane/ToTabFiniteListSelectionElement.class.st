Class {
	#name : #ToTabFiniteListSelectionElement,
	#superclass : #ToListSelectionElement,
	#instVars : [
		'breadth'
	],
	#category : #'Toplo-Widget-TabPane-TabFiniteList'
}

{ #category : #accessing }
ToTabFiniteListSelectionElement >> breadth [

	^ breadth
]

{ #category : #accessing }
ToTabFiniteListSelectionElement >> breadth: aNumber [

	breadth := aNumber
]

{ #category : #initialization }
ToTabFiniteListSelectionElement >> initialize [ 

	super initialize.
	breadth := 8
]

{ #category : #private }
ToTabFiniteListSelectionElement >> positionFrom: aPoint in: aListElement [

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
ToTabFiniteListSelectionElement >> sizeFrom: aPoint in: aListElement [

	aListElement toConfiguration isFlowable ifTrue: [ ^ aPoint ].
	^ aListElement isHorizontal
		  ifTrue: [ aPoint x @ breadth ]
		  ifFalse: [ breadth @ aPoint y ]
]
