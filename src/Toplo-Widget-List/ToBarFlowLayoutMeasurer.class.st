Class {
	#name : #ToBarFlowLayoutMeasurer,
	#superclass : #BlFlowLayoutMeasurer,
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #measure }
ToBarFlowLayoutMeasurer >> measure: anElement with: anExtentSpec [

	| measureAgain lwidth |
	super measure: anElement with: anExtentSpec.
	layout uniformNodeWidth ifFalse: [ ^ self ].
	measureAgain := false.
	lwidth := 0.
	lines do: [ :aLine |
		aLine children do: [ :aChild |
			lwidth := lwidth max: aChild element measuredWidth ] ].
	lines do: [ :aLine |
		aLine children do: [ :aChild |
			aChild element isFake ifFalse: [
				aChild element measuredWidth = lwidth ifFalse: [
					aChild element width: lwidth.
					measureAgain := true ] ] ] ].
	measureAgain ifFalse: [ ^ self ].
	self measure: anElement with: anExtentSpec
]
