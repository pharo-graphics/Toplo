Class {
	#name : #ToElementRightAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementRightAnchor >> applyOnRectangle: aRectangle withValue: aValue withMargin: anInsets [

	^ aRectangle translateBy: aValue - (self read: aRectangle) @ 0
]

{ #category : #applying }
ToElementRightAnchor >> read: aRectangle withMargin: margin [

	^ aRectangle right
	  + (element ifNil: [ 0 ] ifNotNil: [ margin right ])
]
