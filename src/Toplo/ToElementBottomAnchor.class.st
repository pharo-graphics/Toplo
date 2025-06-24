Class {
	#name : #ToElementBottomAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementBottomAnchor >> read: aRectangle [

	^ aRectangle bottom
]

{ #category : #applying }
ToElementBottomAnchor >> translate: aRectangle to: aValue [

	^ aRectangle translateBy: 0 @ (aValue - (self read: aRectangle))
]
