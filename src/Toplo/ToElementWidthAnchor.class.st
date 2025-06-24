Class {
	#name : #ToElementWidthAnchor,
	#superclass : #ToElementAxisAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementWidthAnchor >> applyOnRectangle: aRectangle withValue: aValue withMargin: anInsets [

	^ Rectangle
		  origin: aRectangle origin x + anInsets left @ aRectangle origin y
		  extent: aValue @ aRectangle height
]

{ #category : #applying }
ToElementWidthAnchor >> read: aRectangle withMargin: margin [

	^ aRectangle width
]
