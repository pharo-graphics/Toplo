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
		children do: [ :child |
			| element |
			element := child element.
			element isFake ifFalse: [
				| w h |
				w := child width.
				h := child height.
				layout hasUniformNodeWidth ifTrue: [ w := maxSize x max: w ].
				layout hasUniformNodeHeight ifTrue: [ h := maxSize y max: h ].
				(child width < w or: [ child height < h ]) ifTrue: [
					element measure: (BlExtentMeasurementSpec exact: w @ h).
					child width: w.
					child height: h ] ] ] ]
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

	^ layout hasUniformNodeWidth or: [ layout hasUniformNodeHeight ]
]
