Trait {
	#name : #TToBarMeasurer,
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #'t - bar measurer' }
TToBarMeasurer >> barNodes [

	^ self shouldBeImplemented 
]

{ #category : #'t - bar measurer' }
TToBarMeasurer >> barUniformMeasure [

	self shouldCheckUniformSize ifFalse: [ ^ self ].
	self maxSizeDo: [ :maxSize |
			self barNodes do: [ :child |
					| element w h |
					element := child element.
					w := element measuredWidth.
					h := element measuredHeight.
					self layout uniformNodeWidth ifTrue: [ w := maxSize x max: w ].
					self layout uniformNodeHeight ifTrue: [ h := maxSize y max: h ].
					(element measuredWidth < w or: [ element measuredHeight < h ])
						ifTrue: [
						element measure: (BlExtentMeasurementSpec exact: w @ h) ] ] ]
]

{ #category : #'t - bar measurer' }
TToBarMeasurer >> elementsDo: aBlock [

	self barNodes do: [ :aChild | aBlock value: aChild element ]
]

{ #category : #'t - bar measurer' }
TToBarMeasurer >> maxSizeDo: aBlock [

	| width height |
	width := self layout minNodeWidth ifNil: [ 0 ] ifNotNil: [ :w | w ].
	height := self layout minNodeHeight ifNil: [ 0 ] ifNotNil: [ :w | w ].

	self elementsDo: [ :e |
		| ms |
		ms := self measuredSizeFor: e.
		width := width max: ms x.
		height := height max: ms y ].

	aBlock value: width @ height
]

{ #category : #'t - bar measurer' }
TToBarMeasurer >> measuredSizeFor: anElement [

	^ anElement measuredWidth @ anElement measuredHeight
]

{ #category : #'t - bar measurer' }
TToBarMeasurer >> shouldCheckUniformSize [

	^ self layout uniformNodeWidth or: [ self layout uniformNodeHeight ]
]
