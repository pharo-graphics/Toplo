Class {
	#name : #ToTopLeftResizeGrip,
	#superclass : #ToCornerResizeGrip,
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToTopLeftResizeGrip >> cursorSelector [

	^ #resizeTopLeft
]

{ #category : #initialization }
ToTopLeftResizeGrip >> layoutIn: anElement [

	self size: thickness @ thickness.
	self relocate: ((thickness / 2 @ (thickness / 2)) negated)
	



]

{ #category : #initialization }
ToTopLeftResizeGrip >> newPullHandler [

	^ super newPullHandler
		  relocateX: false;
		  relocateY: false;
		  yourself
]

{ #category : #initialization }
ToTopLeftResizeGrip >> pullEvent: anEvent on: anElement [

	anElement relocate: (self initialTargetPosition x + anEvent delta x) @ (self initialTargetPosition y + anEvent delta y).
	anElement size: (self initialTargetSize x - anEvent delta x) @ (self initialTargetSize y - anEvent delta y)
]
