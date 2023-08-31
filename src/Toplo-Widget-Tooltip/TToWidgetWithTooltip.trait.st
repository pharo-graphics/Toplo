Trait {
	#name : #TToWidgetWithTooltip,
	#category : #'Toplo-Widget-Tooltip'
}

{ #category : #'t - widget with tooltip - private' }
TToWidgetWithTooltip >> checkTooltip [

	self tooltip ifNil: [ self installTooltip ]
]

{ #category : #'t - widget with tooltip - private' }
TToWidgetWithTooltip >> installTooltip [

	self tooltip: self newTooltipWindow
]

{ #category : #'t - widget with tooltip - private' }
TToWidgetWithTooltip >> newTooltipWindow [

	^ self tooltipWindowClass new
		  widget: self;
		  yourself
]

{ #category : #'t - widget with tooltip - private' }
TToWidgetWithTooltip >> removeTooltip [

	self tooltip ifNotNil: [ :tooltip | tooltip close ]
]

{ #category : #'t - widget with tooltip - accessing' }
TToWidgetWithTooltip >> tooltip [

	^ self userData at: #tooltip ifAbsent: [  ]
]

{ #category : #'t - widget with tooltip - accessing' }
TToWidgetWithTooltip >> tooltip: aTooltip [

	self userData at: #tooltip put: aTooltip
]

{ #category : #'t - widget with tooltip - accessing' }
TToWidgetWithTooltip >> tooltipContent [

	^ self tooltip ifNotNil: [ :tooltip | tooltip content ifNotNil:[ :e | e asString ] ]
]

{ #category : #'t - widget with tooltip - accessing' }
TToWidgetWithTooltip >> tooltipContent: aString [

	self tooltipContent = aString ifTrue: [ ^ self ].

	self checkTooltip.
	self tooltip content: aString asRopedText
]

{ #category : #'t - widget with tooltip - accessing' }
TToWidgetWithTooltip >> tooltipDo: aBlock [

	self tooltip
		ifNil: [ ^ self ]
		ifNotNil: [ :tooltip | aBlock value: tooltip ]
]

{ #category : #'t - widget with tooltip - accessing' }
TToWidgetWithTooltip >> tooltipString: aString [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self tooltipContent: aString asRopedText
]

{ #category : #'t - widget with tooltip - accessing' }
TToWidgetWithTooltip >> tooltipWindowClass [

	^ ToTooltipWindow 
]

{ #category : #'t - widget with tooltip - change hook' }
TToWidgetWithTooltip >> whenTooltipChangedDo: aBlock [
	"Inform when tooltip property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self checkTooltip.
	self tooltip whenContentChangedDo: aBlock
]
