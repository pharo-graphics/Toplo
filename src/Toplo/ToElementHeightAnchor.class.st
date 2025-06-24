Class {
	#name : #ToElementHeightAnchor,
	#superclass : #ToElementAxisAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementHeightAnchor >> applyOnRectangle: aRectangle withValue: aValue withMargin: anInsets [

	^ Rectangle
		  origin: aRectangle origin x @ (aRectangle origin y + anInsets top)
		  extent: aRectangle width @ aValue
]

{ #category : #applying }
ToElementHeightAnchor >> read: aRectangle withMargin: margin [

	^ aRectangle height
]
