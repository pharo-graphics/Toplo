Class {
	#name : #ToPolyElement,
	#superclass : #BlElement,
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToPolyElement >> initialize [

	super initialize.
	self layout: BlLinearLayout vertical.
	self geometry: OBlAjacentRectanglesGeometry new.

]

{ #category : #initialization }
ToPolyElement >> measureGeometry [

	| childrenBounds |
	childrenBounds := Array streamContents: [ :aStream | 
		                  self childrenDo: [ 
			                  :childElement | 
			                  aStream nextPut: ((childElement measuredBounds  asRectangle "expandBy: childElement margin asMargin) expandBy: self margin asMargin")) ] ].
	self geometry adjacentRectangles: childrenBounds
]

{ #category : #initialization }
ToPolyElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	self measureGeometry.
	super onLayout: (BlBounds origin: aBounds origin extent: self geometry extent) context: aBlElementBoundsUpdateContext.


]

{ #category : #initialization }
ToPolyElement >> onMeasure: anExtentMeasurementSpec [

	self measureGeometry.
	super onMeasure: (BlExtentMeasurementSpec exact: (Rectangle encompassing: self geometry vertices) extent)
	"super onMeasure: anExtentMeasurementSpec"
]
