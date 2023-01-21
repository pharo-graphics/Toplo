Class {
	#name : #ToPolyElement,
	#superclass : #BlElement,
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToPolyElement >> initialize [

	super initialize.
	self geometry: OBlAjacentRectanglesGeometry new.

]
