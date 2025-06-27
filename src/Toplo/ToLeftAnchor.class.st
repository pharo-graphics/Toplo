Class {
	#name : #ToLeftAnchor,
	#superclass : #ToEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToLeftAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	^ aRectangle translateBy: aValue - aRectangle left @ 0
]

{ #category : #applying }
ToLeftAnchor >> valueForChild: aChildElement withBoundsRectangle: aRectangle [

	^ aRectangle left - element margin left
]
