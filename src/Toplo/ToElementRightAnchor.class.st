Class {
	#name : #ToElementRightAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementRightAnchor >> read: aRectangle [

	^ aRectangle right
]

{ #category : #applying }
ToElementRightAnchor >> translate: aRectangle to: aValue [

	^ aRectangle translateBy: aValue - (self read: aRectangle) @ 0
]
