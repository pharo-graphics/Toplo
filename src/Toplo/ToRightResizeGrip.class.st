Class {
	#name : #ToRightResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #initialization }
ToRightResizeGrip >> attachTo: anElement [

	super attachTo: anElement.
	self width: self thickness.
	self constraintsDo: [ :c |
			c anchors add: (c anchors rightAnchor on: anElement rightAnchor).
			c anchors add:
				(c anchors topAnchor on: anElement topAnchor + self thickness).
			c anchors add: (c anchors heightAnchor on:
					 anElement heightAnchor - (self thickness * 2)) ]
]

{ #category : #accessing }
ToRightResizeGrip >> cursorSelector [

	^ #resizeRight
]

{ #category : #'mouse processing' }
ToRightResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement extent:
		initialExtent x + deltaFromInitialPosition x
		@ initialExtent y
]
