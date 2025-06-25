Class {
	#name : #ToElementLeftAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementLeftAnchor >> applyOnRectangle: aRectangle withValue: aValue withMargin: anInsets [

	^ aRectangle translateBy:
		  aValue - (self read: aRectangle) @ 0
]

{ #category : #applying }
ToElementLeftAnchor >> read: aRectangle withMargin: margin [

	^ aRectangle left - (element ifNil: [ 0 ] ifNotNil: [ margin left ])
]
