Class {
	#name : #ToTopResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #initialization }
ToTopResizeGrip >> attachTo: anElement [

	super attachTo: anElement.
	self height: self thickness.
	self constraintsDo: [ :c |
			c anchors add: (c anchors topAnchor on: anElement topAnchor).
			c anchors add:
				(c anchors leftAnchor on: anElement leftAnchor + self thickness).
			c anchors add: (c anchors widthAnchor on:
					 anElement widthAnchor - (self thickness * 2)) ]
]

{ #category : #accessing }
ToTopResizeGrip >> cursorSelector [

	^ #resizeTop
]

{ #category : #'mouse processing' }
ToTopResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement position:
		initialPosition x
		@ (initialPosition y + deltaFromInitialPosition y).
	anElement extent:
		initialExtent x
		@ (initialExtent y - deltaFromInitialPosition y)
]
