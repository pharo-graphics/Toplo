Class {
	#name : 'ToPolyElement',
	#superclass : 'ToElement',
	#category : 'Toplo-Incubator',
	#package : 'Toplo-Incubator'
}

{ #category : 'initialization' }
ToPolyElement >> initialize [

	super initialize.
	self geometry: ToAjacentRectanglesGeometry new.

]
