Class {
	#name : #ToBarFlowLayoutMeasurer,
	#superclass : #BlFlowLayoutMeasurer,
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #measure }
ToBarFlowLayoutMeasurer >> measure: anElement with: anExtentSpec [

	| lwidth lheight measureAgain |
	super measure: anElement with: anExtentSpec.
	
	(layout uniformNodeWidth or: [ layout uniformNodeHeight ]) ifFalse: [
		^ self ].

	lwidth := layout wishedNodeWidth ifNil: [ 0 ] ifNotNil: [ :w | w ].
	lheight := layout wishedNodeHeight ifNil: [ 0 ] ifNotNil: [ :w | w ].
	measureAgain := false.

	lines do: [ :aLine |
		aLine children do: [ :aChild |
			| ms |
			ms := self measuredSizeFor: aChild element.
			lwidth := lwidth max: ms x.
			lheight := lheight max: ms y ] ].

	lines do: [ :aLine |
		aLine children do: [ :aChild |
			aChild element isFake ifFalse: [
				layout uniformNodeWidth ifTrue: [
					aChild element measuredWidth < lwidth ifTrue: [
						aChild element width: lwidth.
						measureAgain := true ] ].
				layout uniformNodeHeight ifTrue: [
					aChild element measuredHeight < lheight ifTrue: [
						aChild element height: lheight.
						measureAgain := true ] ] ] ] ].

	measureAgain ifFalse: [ ^ self ].
	self measure: anElement with: anExtentSpec
]

{ #category : #measure }
ToBarFlowLayoutMeasurer >> measuredSizeFor: anElement [

	^ anElement measuredWidth @ anElement measuredHeight
]
