Class {
	#name : #ToBarFlowLayoutMeasurer,
	#superclass : #BlFlowLayoutMeasurer,
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #measure }
ToBarFlowLayoutMeasurer >> elementsDo: aBlock [

	children do: [ :aChild | aBlock value: aChild element ]
]

{ #category : #measure }
ToBarFlowLayoutMeasurer >> fillChildrenFor: anElement with: anExtentSpec [

	super fillChildrenFor: anElement with: anExtentSpec.
	self shouldCheckUniformSize ifFalse: [ ^ self ].

	self maxSizeDo: [ :maxSize |
		| mw mh |
		mw := maxSize x.
		mh := maxSize y.

		children do: [ :child |
			| element |
			element := child element.
			element isFake ifFalse: [
				| esize w h |
				esize := element measuredExtent.
				w := esize x.
				h := esize y.
				layout uniformNodeWidth ifTrue: [ w := mw max: w ].
				layout uniformNodeHeight ifTrue: [ h := mh max: h ].
				(esize x = w and: [ esize y = h ]) ifFalse: [
					element measure: (BlExtentMeasurementSpec exact: w @ h).
					child width: element measuredWidth.
					child height: element measuredHeight ] ] ] ]
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
ToBarFlowLayoutMeasurer >> measuredSizeFor: anElement [

	^ anElement measuredWidth @ anElement measuredHeight
]

{ #category : #measure }
ToBarFlowLayoutMeasurer >> shouldCheckUniformSize [

	^ layout uniformNodeWidth or: [ layout uniformNodeHeight ]
]
