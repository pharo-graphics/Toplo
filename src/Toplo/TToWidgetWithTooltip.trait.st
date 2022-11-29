Trait {
	#name : #TToWidgetWithTooltip,
	#category : #'Toplo-Core'
}

{ #category : #'t - api - tooltip' }
TToWidgetWithTooltip >> checkTooltip [

	self tooltip ifNil: [ self installTooltip ]
]

{ #category : #'t - api - tooltip' }
TToWidgetWithTooltip >> installTooltip [

	self tooltip: self newTooltipWidget.
	self tooltip onInstalledIn: self
]

{ #category : #'t - api - tooltip' }
TToWidgetWithTooltip >> newTooltipWidget [

	^ self tooltipWidgetClass new
]

{ #category : #'t - api - tooltip' }
TToWidgetWithTooltip >> removeTooltip [

	self tooltip ifNotNil: [ :tooltip | tooltip removePopup ]
]

{ #category : #'t - accessing' }
TToWidgetWithTooltip >> tooltip [

	^ self userData at: #tooltip ifAbsent: [  ]
]

{ #category : #'t - accessing' }
TToWidgetWithTooltip >> tooltip: aTooltip [

	self userData at: #tooltip put: aTooltip
]

{ #category : #'t - api - tooltip' }
TToWidgetWithTooltip >> tooltipContent [

	^ self tooltip ifNotNil: [ :tooltip | tooltip content ]
]

{ #category : #'t - api - tooltip' }
TToWidgetWithTooltip >> tooltipContent: aTooltipContent [

	self checkTooltip.
	self tooltip content: aTooltipContent asRopedText

]

{ #category : #'t - accessing' }
TToWidgetWithTooltip >> tooltipDo: aBlock [

	self tooltip
		ifNil: [ ^ self ]
		ifNotNil: [ :tooltip | aBlock value: tooltip ]
]

{ #category : #'t - api - tooltip' }
TToWidgetWithTooltip >> tooltipString: aString [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self tooltipContent: aString asRopedText
]

{ #category : #'t - api - tooltip' }
TToWidgetWithTooltip >> tooltipWidgetClass [

	^ ToTooltip 
]

{ #category : #'t - api - properties change hook' }
TToWidgetWithTooltip >> whenTooltipChangedDo: aBlock [
	"Inform when tooltip property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self checkTooltip.
	self tooltip whenContentChangedDo: aBlock
]
