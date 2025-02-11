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

	| lwidth lheight |
	
	lwidth := layout wishedNodeWidth ifNil: [ 0 ] ifNotNil: [ :w | w ].
	lheight := layout wishedNodeHeight ifNil: [ 0 ] ifNotNil: [ :w | w ].

	self elementsDo: [ :e |
		| ms |
		ms := self measuredSizeFor: e.
		lwidth := lwidth max: ms x.
		lheight := lheight max: ms y ].

	aBlock value: lwidth @ lheight
]

{ #category : #measure }
ToBarFlowLayoutMeasurer >> measure: anElement with: anExtentSpec [

	super measure: anElement with: anExtentSpec.

	(layout uniformNodeWidth or: [ layout uniformNodeHeight ]) ifFalse: [
		^ self ].
	(self uniformMeasure: anElement with: anExtentSpec) ifFalse: [ ^ self ].

	self measure: anElement with: anExtentSpec
]

{ #category : #measure }
ToBarFlowLayoutMeasurer >> measuredSizeFor: anElement [

	^ anElement measuredWidth @ anElement measuredHeight
]

{ #category : #measure }
ToBarFlowLayoutMeasurer >> uniformMeasure: anElement with: anExtentSpec [

	| measureAgain |
	measureAgain := false.

	self maxSizeDo: [ :maxSize |
		| lwidth lheight |
		lwidth := maxSize x.
		lheight := maxSize y.

		self elementsDo: [ :e |
			e isFake ifFalse: [
				| mw mh |
				mw := e measuredWidth.
				mh := e measuredHeight.

				layout uniformNodeWidth ifTrue: [
					mw < lwidth ifTrue: [
						mw := lwidth.
						measureAgain := true ] ].

				layout uniformNodeHeight ifTrue: [
					mh < lheight ifTrue: [
						mh := lheight.
						measureAgain := true ] ].

				e size: mw @ mh ] ] ].

	^ measureAgain
]
