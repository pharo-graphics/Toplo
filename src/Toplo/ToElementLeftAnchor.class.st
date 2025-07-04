Class {
	#name : #ToElementLeftAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementLeftAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	^ aRectangle translateBy: aValue - aRectangle left @ 0
]

{ #category : #applying }
ToElementLeftAnchor >> readRectangle: aRectangle [

	^ aRectangle left - element margin left
]
