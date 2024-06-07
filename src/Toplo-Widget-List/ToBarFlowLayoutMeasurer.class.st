Class {
	#name : #ToBarFlowLayoutMeasurer,
	#superclass : #BlFlowLayoutMeasurer,
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #measure }
ToBarFlowLayoutMeasurer >> measure: anElement with: anExtentSpec [

	| measureAgain lwidth |
	super measure: anElement with: anExtentSpec.
	layout lineUniformWidth ifFalse: [ ^ self ].
	measureAgain := false.
	lwidth := 0.
	lines do: [ :aLine |
		aLine children do: [ :aChild |
			lwidth := lwidth max: aChild width.
			aChild element measuredWidth = lwidth ifFalse: [
				measureAgain := true ] ] ].
	measureAgain ifFalse: [ ^ self ].
	lines do: [ :aLine |
		aLine children do: [ :aChild |
			aChild element holder position isZero ifFalse: [
				aChild width: lwidth.
				aChild element constraints horizontal exact: lwidth ] ] ].
	self measure: anElement with: anExtentSpec
]
