Class {
	#name : #ToElementWidthAnchor,
	#superclass : #ToElementAxisAnchor,
	#category : #'Toplo-Support-Anchor'
}

{ #category : #applying }
ToElementWidthAnchor >> appliedOnRectangle: aRectangle withValue: aValue [ 

	^ Rectangle
		  origin: aRectangle origin x + element margin left @ aRectangle origin y
		  extent: aValue @ aRectangle height
]

{ #category : #testing }
ToElementWidthAnchor >> isMeasurement [

	^ true
]

{ #category : #applying }
ToElementWidthAnchor >> readRectangle: aRectangle [

	^ aRectangle width - element margin width
]
