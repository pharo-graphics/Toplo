Class {
	#name : #ToAdjacentRectanglesGeometry,
	#superclass : #BlPolygonGeometry,
	#instVars : [
		'collector'
	],
	#category : #'Toplo-Incubator'
}

{ #category : #accessing }
ToAdjacentRectanglesGeometry class >> oppositeDelimiterBackgroundColor [
	^ Color lightGray
]

{ #category : #accessing }
ToAdjacentRectanglesGeometry >> adjacentRectangles: aCollection [
	aCollection ifEmpty: [ ^ self ].
	self vertices: (BlVerticesFromRectanglesOperator new verticesFromRectangles: aCollection)
]

{ #category : #accessing }
ToAdjacentRectanglesGeometry >> collector [

	^ collector
]

{ #category : #accessing }
ToAdjacentRectanglesGeometry >> collector: aValuable [

	" takes the PolyElement as argument "

	collector := aValuable
]

{ #category : #initialization }
ToAdjacentRectanglesGeometry >> initialize [ 

	super initialize.
	collector := [ :element | element children accountedByLayout ]
]

{ #category : #geometry }
ToAdjacentRectanglesGeometry >> matchElement: anElement [

	| bnds children |
	children := self collector value: anElement.
	bnds := Array streamContents: [ :aStream | 
		children do: [ :childElement | 
		aStream nextPut: ((childElement bounds inParent asRectangle expandBy: childElement margin asMargin) expandBy: anElement margin asMargin) ] ].
	self adjacentRectangles: bnds
]
