Class {
	#name : #ToTopRightResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToTopRightResizeGrip >> cursorSelector [

	^ #resizeTopRight
]

{ #category : #initialization }
ToTopRightResizeGrip >> layoutIn: anElement [

	self size: thickness @ thickness.
	self position:
		anElement width - (thickness / 2) @ (thickness / 2) negated
]

{ #category : #'instance creation' }
ToTopRightResizeGrip >> newPullHandler [

	^ super newPullHandler
		  relocateY: false;
		  yourself
]

{ #category : #initialization }
ToTopRightResizeGrip >> pullEvent: anEvent on: anElement [

	anElement position: self initialTargetPosition x
		@ (self initialTargetPosition y + anEvent delta y).
	anElement size: self initialTargetSize x + anEvent delta x
		@ (self initialTargetSize y - anEvent delta y)
]
