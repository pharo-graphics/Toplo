Class {
	#name : 'ToAjacentRectanglesGeometry',
	#superclass : 'BlPolygonGeometry',
	#instVars : [
		'collector'
	],
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'accessing' }
ToAjacentRectanglesGeometry class >> oppositeDelimiterBackgroundColor [
	^ Color lightGray
]

{ #category : 'accessing' }
ToAjacentRectanglesGeometry >> adjacentRectangles: aCollection [
	aCollection ifEmpty: [ ^ self ].
	self vertices: (BlVerticesFromRectanglesOperator new verticesFromRectangles: aCollection)
]

{ #category : 'accessing' }
ToAjacentRectanglesGeometry >> collector [

	^ collector
]

{ #category : 'accessing' }
ToAjacentRectanglesGeometry >> collector: aValuable [

	" takes the PolyElement as argument "

	collector := aValuable
]

{ #category : 'initialization' }
ToAjacentRectanglesGeometry >> initialize [ 

	super initialize.
	collector := [ :element | element children accountedByLayout ]
]

{ #category : 'geometry' }
ToAjacentRectanglesGeometry >> matchElement: anElement [

	| bnds children |
	children := self collector value: anElement.
	bnds := Array streamContents: [ :aStream | 
		children do: [ :childElement | 
		aStream nextPut: ((childElement bounds inParent asRectangle expandBy: childElement margin asMargin) expandBy: anElement margin asMargin) ] ].
	self adjacentRectangles: bnds
]
