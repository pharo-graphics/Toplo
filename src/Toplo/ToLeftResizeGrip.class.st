Class {
	#name : #ToLeftResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #initialization }
ToLeftResizeGrip >> attachTo: anElement [

	super attachTo: anElement.
	self width: self thickness.
	self constraintsDo: [ :c |
			c anchors add: (c anchors leftAnchor on: anElement leftAnchor).
			c anchors add:
				(c anchors topAnchor on: anElement topAnchor + self thickness).
			c anchors add: (c anchors heightAnchor on:
					 anElement heightAnchor - (self thickness * 2)) ]
]

{ #category : #accessing }
ToLeftResizeGrip >> cursorSelector [

	^ #resizeLeft
]

{ #category : #'mouse processing' }
ToLeftResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x + deltaFromInitialPosition x
		@ initialPosition y.
	anElement extent:
		initialExtent x - deltaFromInitialPosition x
		@ initialExtent y
]
