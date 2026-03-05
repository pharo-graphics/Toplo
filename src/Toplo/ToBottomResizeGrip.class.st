Class {
	#name : #ToBottomResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Layout-Support-Grips'
}

{ #category : #'mouse processing' }
ToBottomResizeGrip >> attachTo: anElement [

	super attachTo: anElement.
	self height: self thickness.
	self constraintsDo: [ :c |
			c anchors add: (c anchors bottomAnchor on: anElement bottomAnchor).
			c anchors add:
				(c anchors leftAnchor on: anElement leftAnchor + self thickness).
			c anchors add: (c anchors widthAnchor on:
					 anElement widthAnchor - (self thickness * 2)) ]
]

{ #category : #accessing }
ToBottomResizeGrip >> cursorSelector [

	^ #resizeBottom
]

{ #category : #'mouse processing' }
ToBottomResizeGrip >> drag: anElement by: deltaFromInitialPosition [

	anElement extent:
		initialExtent x
		@ (initialExtent y + deltaFromInitialPosition y)
]
