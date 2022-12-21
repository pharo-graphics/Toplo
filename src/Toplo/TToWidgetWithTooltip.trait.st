Trait {
	#name : #TToWidgetWithTooltip,
	#category : #'Toplo-Core'
}

{ #category : #'t - tooltip private' }
TToWidgetWithTooltip >> checkTooltip [

	self tooltip ifNil: [ self installTooltip ]
]

{ #category : #'t - tooltip private' }
TToWidgetWithTooltip >> installTooltip [

	self tooltip: self newTooltipWindow
]

{ #category : #'t - tooltip private' }
TToWidgetWithTooltip >> newTooltipWindow [

	^ self tooltipWindowClass new
		  widget: self;
		  yourself
]

{ #category : #'t - tooltip private' }
TToWidgetWithTooltip >> removeTooltip [

	self tooltip ifNotNil: [ :tooltip | tooltip close ]
]

{ #category : #'t - accessing tooltip' }
TToWidgetWithTooltip >> tooltip [

	^ self userData at: #tooltip ifAbsent: [  ]
]

{ #category : #'t - accessing tooltip' }
TToWidgetWithTooltip >> tooltip: aTooltip [

	self flag:'PLA : How to uninstall a tooltip ? How to change a tooltip with content reuse ?'.
	self userData at: #tooltip put: aTooltip
]

{ #category : #'t - accessing tooltip' }
TToWidgetWithTooltip >> tooltipContent [

	^ self tooltip ifNotNil: [ :tooltip | tooltip content ifNotNil:[ :e | e asString ] ]
]

{ #category : #'t - accessing tooltip' }
TToWidgetWithTooltip >> tooltipContent: aString [

	self tooltipContent = aString ifTrue: [ ^ self ].

	self checkTooltip.
	self tooltip content: aString asRopedText
]

{ #category : #'t - accessing tooltip' }
TToWidgetWithTooltip >> tooltipDo: aBlock [

	self tooltip
		ifNil: [ ^ self ]
		ifNotNil: [ :tooltip | aBlock value: tooltip ]
]

{ #category : #'t - accessing tooltip' }
TToWidgetWithTooltip >> tooltipString: aString [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self tooltipContent: aString asRopedText
]

{ #category : #'t - tooltip private' }
TToWidgetWithTooltip >> tooltipWindowClass [

	^ ToTooltip 
]

{ #category : #'t - tooltip change hook' }
TToWidgetWithTooltip >> whenTooltipChangedDo: aBlock [
	"Inform when tooltip property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self checkTooltip.
	self tooltip whenContentChangedDo: aBlock
]
