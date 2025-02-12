Class {
	#name : #ToBarFlowLayoutMeasurer,
	#superclass : #BlFlowLayoutMeasurer,
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #measure }
ToBarFlowLayoutMeasurer >> elementsDo: aBlock [

	lines do: [ :aLine |
		aLine children do: [ :aChild | aBlock value: aChild element ] ]
]

{ #category : #measure }
ToBarFlowLayoutMeasurer >> maxSizeDo: aBlock [

	| width height |
	
	width := layout minNodeWidth ifNil: [ 0 ] ifNotNil: [ :w | w ].
	height := layout minNodeHeight ifNil: [ 0 ] ifNotNil: [ :w | w ].

	self elementsDo: [ :e |
		| ms |
		ms := self measuredSizeFor: e.
		width := width max: ms x.
		height := height max: ms y ].

	aBlock value: width @ height
]

{ #category : #measure }
ToBarFlowLayoutMeasurer >> measure: anElement with: anExtentSpec [

	| measureAgain |
	super measure: anElement with: anExtentSpec.
	self shouldCheckUniformSize ifFalse: [ ^ self ].

	measureAgain := false.
	self maxSizeDo: [ :maxSize |
		| width height |
		width := maxSize x.
		height := maxSize y.

		self elementsDo: [ :element |
			element isFake ifFalse: [
				layout uniformNodeWidth ifTrue: [
					element measuredWidth < width ifTrue: [
						element width: width.
						measureAgain := true ] ].
				layout uniformNodeHeight ifTrue: [
					element measuredHeight < height ifTrue: [
						element height: height.
						measureAgain := true ] ] ] ] ].

	measureAgain ifFalse: [ ^ self ].
	self measure: anElement with: anExtentSpec
]

{ #category : #measure }
ToBarFlowLayoutMeasurer >> measuredSizeFor: anElement [

	^ anElement measuredWidth @ anElement measuredHeight
]

{ #category : #measure }
ToBarFlowLayoutMeasurer >> shouldCheckUniformSize [

	^ layout uniformNodeWidth or: [ layout uniformNodeHeight ]
]
