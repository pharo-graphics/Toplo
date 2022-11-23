Class {
	#name : #ToTopRightResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-Frame'
}

{ #category : #accessing }
ToTopRightResizeGrip >> cursorSelector [

	^ #resizeTopRight
]

{ #category : #initialization }
ToTopRightResizeGrip >> layoutIn: anElement [

	self relocate: (anElement size x - (self width / 2)) @ ((self height / 2) negated)



]

{ #category : #'instance creation' }
ToTopRightResizeGrip >> newPullHandler [

	^ super newPullHandler
		  relocateY: false;
		  yourself
]

{ #category : #initialization }
ToTopRightResizeGrip >> pullEvent: anEvent on: anElement [

	anElement relocate: self initialTargetPosition x  @ (self initialTargetPosition y + anEvent delta y).
	anElement size: (self initialTargetSize x + anEvent delta x) @ (self initialTargetSize y - anEvent delta y)
]
