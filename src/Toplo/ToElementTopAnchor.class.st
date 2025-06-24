Class {
	#name : #ToElementTopAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementTopAnchor >> read: aRectangle [

	^ aRectangle top
]

{ #category : #applying }
ToElementTopAnchor >> translate: aRectangle to: aValue [

	^ aRectangle translateBy: 0 @ (aValue - (self read: aRectangle))
]
