Class {
	#name : #ToElementTopAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementTopAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	^ aRectangle translateBy: 0 @ (aValue - aRectangle top)
]

{ #category : #applying }
ToElementTopAnchor >> readRectangle: aRectangle [ 

	^ aRectangle top - element margin top
]
