Class {
	#name : #ToTopResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-InnerWindow'
}

{ #category : #accessing }
ToTopResizeGrip >> cursorSelector [

	^ #resizeTop
]

{ #category : #initialization }
ToTopResizeGrip >> layoutIn: anElement [

	self relocate: self defaultThickness @ (self height / 2) negated.
	self size: (anElement width - (self defaultThickness * 2)) @ self defaultThickness
]

{ #category : #initialization }
ToTopResizeGrip >> newPullHandler [

	^ super newPullHandler
		  beVertical;
		  relocateY: false;
		  yourself
]

{ #category : #initialization }
ToTopResizeGrip >> pullEvent: anEvent on: anElement [

	anElement relocate: (self initialTargetPosition x ) @ (self initialTargetPosition y + anEvent delta y).
	anElement size: (self initialTargetSize x ) @ (self initialTargetSize y - anEvent delta y)
]
