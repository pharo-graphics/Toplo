Class {
	#name : #ToElementTopAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementTopAnchor >> applyOnRectangle: aRectangle withValue: aValue withMargin: anInsets [

	^ aRectangle translateBy:
		  0 @ (aValue - (self read: aRectangle withMargin: anInsets))
]

{ #category : #applying }
ToElementTopAnchor >> read: aRectangle withMargin: margin [

	^ aRectangle top - (element ifNil: [ 0 ] ifNotNil: [ margin top ])
]
