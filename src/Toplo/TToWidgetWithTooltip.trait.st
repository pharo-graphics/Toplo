Trait {
	#name : #TToWidgetWithTooltip,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'t - widget with tooltip - testing' }
TToWidgetWithTooltip >> hasTooltip [

	^ self privateTooltipWindow notNil
]

{ #category : #'t - widget with tooltip - private' }
TToWidgetWithTooltip >> newTooltipWindow [

	^ self tooltipWindowClass new
		  widget: self;
		  yourself
]

{ #category : #'t - widget with tooltip - private' }
TToWidgetWithTooltip >> privateCheckTooltipWindowInstallation [

	self privateTooltipWindow ifNil: [ self privateInstallTooltipWindow ]
]

{ #category : #'t - widget with tooltip - private' }
TToWidgetWithTooltip >> privateInstallTooltipWindow [

	self privateTooltipWindow: self newTooltipWindow
]

{ #category : #'t - widget with tooltip - private' }
TToWidgetWithTooltip >> privateTooltipWindow [

	^ self userData at: #privateTooltipWindow ifAbsent: [  ]
]

{ #category : #'t - widget with tooltip - private' }
TToWidgetWithTooltip >> privateTooltipWindow: aTooltip [

	aTooltip ifNil: [
		self userData removeKey: #privateTooltipWindow.
		^ self ].
	self userData at: #privateTooltipWindow put: aTooltip
]

{ #category : #'t - widget with tooltip - private' }
TToWidgetWithTooltip >> privateTooltipWindowDo: aBlock [

	self privateTooltipWindow
		ifNotNil: [ :tooltip | aBlock value: tooltip ]
]

{ #category : #'t - widget with tooltip - private' }
TToWidgetWithTooltip >> removeTooltip [

	self privateTooltipWindowDo: [ :tooltip |
		tooltip detachFromWidget.
		self privateTooltipWindow: nil ]
]

{ #category : #'t - widget with tooltip - accessing' }
TToWidgetWithTooltip >> tooltipContent [

	^ self privateTooltipWindow ifNotNil: [ :ptw | ptw content ]
]

{ #category : #'t - widget with tooltip - accessing' }
TToWidgetWithTooltip >> tooltipContent: anElement [

	self hasTooltip ifTrue: [
		self tooltipContent = anElement ifTrue: [ ^ self ] ].
	anElement ifNil: [
		self removeTooltip.
		^ self ].
	self privateCheckTooltipWindowInstallation.
	self privateTooltipWindow content: anElement
]

{ #category : #'t - widget with tooltip - accessing' }
TToWidgetWithTooltip >> tooltipString: aString [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self tooltipText: aString asRopedText
]

{ #category : #'t - widget with tooltip - accessing' }
TToWidgetWithTooltip >> tooltipText: aText [

	self tooltipContent: ((ToLabel text: aText asRopedText)
			 beMultiLine;
			 yourself)
]

{ #category : #'t - widget with tooltip - private' }
TToWidgetWithTooltip >> tooltipWindowClass [

	^ ToTooltipWindow 
]
