Class {
	#name : #ToBarFlowLayoutMeasurer,
	#superclass : #BlFlowLayoutMeasurer,
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #measure }
ToBarFlowLayoutMeasurer >> measure: anElement with: anExtentSpec [

	| measureAgain |

	super measure: anElement with: anExtentSpec.
	layout lineUniformWidth ifFalse: [ ^ self ].
	measureAgain := false.
	lines do: [ :aLine |
		| lwidth |
		lwidth := 0.
		aLine children do: [ :aChild | lwidth := lwidth max: aChild width ].
		aLine children do: [ :aChild |
			aChild width: lwidth.
			aChild element measuredWidth = lwidth ifFalse: [
				measureAgain := true ].
			aChild element width: lwidth ] ].
	measureAgain ifTrue: [ self measure: anElement with: anExtentSpec ]
]
