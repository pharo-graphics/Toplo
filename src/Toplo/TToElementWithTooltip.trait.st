Trait {
	#name : #TToElementWithTooltip,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'t - element with tooltip - private' }
TToElementWithTooltip >> currentTooltipWindow [

	^ self tooltipWindowHandler ifNotNil: [ :h | h currentWindow ] 
]

{ #category : #'t - element with tooltip - testing' }
TToElementWithTooltip >> hasTooltip [

	^ self privateTooltipContent notNil
]

{ #category : #'t - element with tooltip - private' }
TToElementWithTooltip >> newTooltipWindowEvent: anEvent [

	^ self tooltipWindowHandler newWindowEvent: anEvent
]

{ #category : #'t - element with tooltip - accessing' }
TToElementWithTooltip >> privateTooltipContent [

	^ self userData at: #tooltipContent ifAbsent: [  ]
]

{ #category : #'t - element with tooltip - accessing' }
TToElementWithTooltip >> privateTooltipContent: anElement [

	anElement ifNil: [
		self userData removeKey: #tooltipContent ifAbsent: [  ].
		^ self ].
	self userData at: #tooltipContent put: anElement
]

{ #category : #'t - element with tooltip - accessing' }
TToElementWithTooltip >> removeTooltip [

	self removeTooltipWindowHandler.
	self tooltipContent: nil
]

{ #category : #'t - element with tooltip - accessing' }
TToElementWithTooltip >> removeTooltipWindowHandler [

	| handler |
	handler := self userData
		           at: #tooltipWindowHandler
		           ifAbsent: [ ^ self ].
	handler hasWindow ifTrue: [ handler closeWindow ].
	handler element: nil.
	self userData removeKey: #tooltipWindowHandler
]

{ #category : #'t - element with tooltip - accessing' }
TToElementWithTooltip >> tooltipContent [

	^ self privateTooltipContent 
]

{ #category : #'t - element with tooltip - accessing' }
TToElementWithTooltip >> tooltipContent: anElement [

	self privateTooltipContent: anElement.
	anElement ifNil: [
		self removeTooltipWindowHandler.
		^ self ].
	self tooltipWindowHandler: ToTooltipWindowHandler new.
	self tooltipWindowHandler builder: [ ToTooltipWindow new content: anElement; yourself ]
]

{ #category : #'t - element with tooltip - accessing' }
TToElementWithTooltip >> tooltipString: aString [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self tooltipText: aString asRopedText
]

{ #category : #'t - element with tooltip - accessing' }
TToElementWithTooltip >> tooltipText: aText [

	self tooltipContent: ((ToLabel text: aText asRopedText)
			 beMultiLine;
			 yourself)
]

{ #category : #'t - element with tooltip - accessing' }
TToElementWithTooltip >> tooltipWindowHandler [

	^ self userData at: #tooltipWindowHandler ifAbsent: [  ]
]

{ #category : #'t - element with tooltip - accessing' }
TToElementWithTooltip >> tooltipWindowHandler: aWindowHandler [

	self tooltipWindowHandler = aWindowHandler ifTrue: [ ^ self ].
	self removeTooltipWindowHandler.
	aWindowHandler ifNil: [ ^ self ].
	self userData at: #tooltipWindowHandler put: (aWindowHandler
			 element: self;
			 yourself)
]
