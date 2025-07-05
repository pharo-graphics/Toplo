Class {
	#name : #ToElementExtentAnchor,
	#superclass : #ToElementLocationAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementExtentAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	^ Rectangle
		  origin: aRectangle origin
		  extent: aValue 
]

{ #category : #testing }
ToElementExtentAnchor >> isMeasurement [

	^ true
]

{ #category : #applying }
ToElementExtentAnchor >> readRectangle: aRectangle [

	^ aRectangle extent
]
