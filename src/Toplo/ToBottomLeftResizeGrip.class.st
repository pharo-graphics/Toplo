Class {
	#name : #ToBottomLeftResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToBottomLeftResizeGrip >> cursorSelector [

	^ #resizeBottomLeft
]

{ #category : #initialization }
ToBottomLeftResizeGrip >> layoutIn: anElement [

	self size: thickness @ thickness.
	self position:
		0 @ anElement height - (thickness / 2 @ (thickness / 2))
]

{ #category : #'instance creation' }
ToBottomLeftResizeGrip >> newPullHandler [

	^ super newPullHandler
		  relocateX: false;
		  yourself
]

{ #category : #initialization }
ToBottomLeftResizeGrip >> pullEvent: anEvent on: anElement [

	anElement position: self initialTargetPosition x + anEvent delta x
		@ self initialTargetPosition y.
	anElement size: self initialTargetSize x - anEvent delta x
		@ (self initialTargetSize y + anEvent delta y)
]
