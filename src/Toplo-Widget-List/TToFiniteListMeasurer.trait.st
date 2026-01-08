Trait {
	#name : #TToFiniteListMeasurer,
	#category : #'Toplo-Widget-List-NotUsed-InnerList-Finite-Layout'
}

{ #category : #'t - finite list measurer' }
TToFiniteListMeasurer >> barNodes [

	^ self shouldBeImplemented 
]

{ #category : #'t - finite list measurer' }
TToFiniteListMeasurer >> barUniformMeasure [

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

{ #category : #'t - finite list measurer' }
TToFiniteListMeasurer >> elementsDo: aBlock [

	self barNodes do: [ :aChild | aBlock value: aChild element ]
]

{ #category : #'t - finite list measurer' }
TToFiniteListMeasurer >> maxSizeDo: aBlock [

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

{ #category : #'t - finite list measurer' }
TToFiniteListMeasurer >> measuredSizeFor: anElement [

	^ anElement measuredWidth @ anElement measuredHeight
]

{ #category : #'t - finite list measurer' }
TToFiniteListMeasurer >> shouldCheckUniformSize [

	^ self layout uniformNodeWidth or: [ self layout uniformNodeHeight ]
]
