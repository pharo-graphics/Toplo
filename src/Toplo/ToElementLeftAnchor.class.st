Class {
	#name : #ToElementLeftAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementLeftAnchor >> read: aRectangle [

	^ aRectangle left
]

{ #category : #applying }
ToElementLeftAnchor >> translate: aRectangle to: aValue [

	^ aRectangle translateBy: aValue - (self read: aRectangle) @ 0
]
