Class {
	#name : #ToBarFlowLayoutMeasurer,
	#superclass : #BlFlowLayoutMeasurer,
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #measure }
ToBarFlowLayoutMeasurer >> measure: anElement with: anExtentSpec [

	| measureAgain lwidth lheight |
	super measure: anElement with: anExtentSpec.
	(layout uniformNodeWidth or: [ layout uniformNodeHeight ]) ifFalse: [
		^ self ].

	measureAgain := false.

	lwidth := 0.
	lheight := 0.

	lines do: [ :aLine |
		aLine children do: [ :aChild |
			lwidth := lwidth max: aChild element measuredWidth.
			lheight := lheight max: aChild element measuredHeight ] ].

	lines do: [ :aLine |
		aLine children do: [ :aChild |
			aChild element isFake ifFalse: [
				layout uniformNodeWidth ifTrue: [
					aChild element measuredWidth = lwidth ifFalse: [
						aChild element width: lwidth.
						measureAgain := true ] ].
				layout uniformNodeHeight ifTrue: [
					aChild element measuredHeight = lheight ifFalse: [
						aChild element height: lheight.
						measureAgain := true ] ] ] ] ].

	measureAgain ifFalse: [ ^ self ].
	self measure: anElement with: anExtentSpec
]
