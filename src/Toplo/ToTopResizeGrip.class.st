Class {
	#name : #ToTopResizeGrip,
	#superclass : #ToBorderResizeGrip,
	#category : #'Toplo-Widget-Window'
}

{ #category : #accessing }
ToTopResizeGrip >> cursorSelector [

	^ #resizeTop
]

{ #category : #initialization }
ToTopResizeGrip >> layoutIn: anElement [

	self size: (anElement width - (thickness * 2)) @ thickness.
	self relocate: thickness @ (thickness / 2) negated.

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
