Class {
	#name : #ToTripletLinearLayoutHorizontalOrientation,
	#superclass : #BlLinearLayoutHorizontalOrientation,
	#category : #'Toplo-Core-Triplet'
}

{ #category : #layout }
ToTripletLinearLayoutHorizontalOrientation >> tunedChildBounds: aChildBounds of: aChild in: anElement turn: aTurnNumber context: aBlElementBoundsUpdateContext [

	| frontAlignmentGap newBounds |
	newBounds := super
		tunedChildBounds: aChildBounds
		of: aChild
		in: anElement
		turn: aTurnNumber
		context: aBlElementBoundsUpdateContext.

	" only second child is impacted by front alignment "
	(aTurnNumber = 2 and: [ self layout frontAlignmentSpacing > 0.0 ])
		ifFalse: [ ^ newBounds ].

	" no change if the child left is already beyond the alignment "
	aChildBounds left < self layout frontAlignmentSpacing ifFalse: [
		^ newBounds ].

	frontAlignmentGap := self layout frontAlignmentSpacing - aChildBounds left.
	frontAlignmentGap isZero ifTrue: [ ^ newBounds ].
	
	" adapt the element extent according to the front alignment "
	anElement
		position: anElement position
		extent: anElement measuredExtent + (frontAlignmentGap @ 0.0)
		context: aBlElementBoundsUpdateContext.

	^ aChildBounds translateBy: frontAlignmentGap @ 0.0.

]
