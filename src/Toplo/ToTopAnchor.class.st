Class {
	#name : #ToTopAnchor,
	#superclass : #ToEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToTopAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	^ aRectangle translateBy: 0 @ (aValue - aRectangle top)
]

{ #category : #applying }
ToTopAnchor >> valueForChild: aChildElement withBoundsRectangle: aRectangle [

	^ aRectangle top - element margin top
]
