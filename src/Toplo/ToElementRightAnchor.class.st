Class {
	#name : #ToElementRightAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementRightAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	^ aRectangle translateBy: aValue - aRectangle right @ 0
]

{ #category : #applying }
ToElementRightAnchor >> readRectangle: aRectangle [ 

	^ aRectangle right + element margin right
]
