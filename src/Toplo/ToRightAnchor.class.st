Class {
	#name : #ToRightAnchor,
	#superclass : #ToEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToRightAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	^ aRectangle translateBy: aValue - aRectangle right @ 0
]

{ #category : #applying }
ToRightAnchor >> valueForChild: aChildElement withBoundsRectangle: aRectangle [

	^ aRectangle right + element margin right
]
