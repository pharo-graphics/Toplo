Class {
	#name : #ToPolyElement,
	#superclass : #ToElement,
	#category : 'Toplo-Core'
}

{ #category : #initialization }
ToPolyElement >> initialize [

	super initialize.
	self geometry: ToAjacentRectanglesGeometry new.

]
