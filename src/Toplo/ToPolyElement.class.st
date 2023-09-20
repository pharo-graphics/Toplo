Class {
	#name : 'ToPolyElement',
	#superclass : 'ToElement',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'initialization' }
ToPolyElement >> initialize [

	super initialize.
	self geometry: ToAjacentRectanglesGeometry new.

]
