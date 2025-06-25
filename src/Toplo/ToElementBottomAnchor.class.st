Class {
	#name : #ToElementBottomAnchor,
	#superclass : #ToElementEdgeAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementBottomAnchor >> applyOnRectangle: aRectangle withValue: aValue withMargin: anInsets [

	^ aRectangle translateBy:
		  0 @ (aValue - (self read: aRectangle))
]

{ #category : #applying }
ToElementBottomAnchor >> read: aRectangle withMargin: margin [

	^ aRectangle bottom
	  + (element ifNil: [ 0 ] ifNotNil: [ margin bottom ])
]
