Trait {
	#name : 'TToElementWithTooltip',
	#category : 'Toplo-Core-Tooltip',
	#package : 'Toplo',
	#tag : 'Core-Tooltip'
}

{ #category : 't - element with tooltip - private' }
TToElementWithTooltip >> currentTooltipWindow [

	^ self tooltipWindowHandler ifNotNil: [ :h | h currentWindow ] 
]

{ #category : 't - element with tooltip - testing' }
TToElementWithTooltip >> hasTooltip [

	^ self tooltipContent notNil
]

{ #category : 't - element with tooltip - private' }
TToElementWithTooltip >> newTooltipWindowEvent: anEvent [

	^ self tooltipWindowHandler newWindowEvent: anEvent
]

{ #category : 't - element with tooltip - private' }
TToElementWithTooltip >> privateRemoveTooltipWindowHandler [

	| handler |
	handler := self userData
		           at: #tooltipWindowHandler
		           ifAbsent: [ ^ self ].
	handler hasWindow ifTrue: [ handler closeWindow ].
	handler element: nil.
	self userData removeKey: #tooltipWindowHandler
]

{ #category : 't - element with tooltip - accessing' }
TToElementWithTooltip >> removeTooltip [

	self privateRemoveTooltipWindowHandler.
	self tooltipContent: nil
]

{ #category : 't - element with tooltip - accessing' }
TToElementWithTooltip >> tooltip [

	^ self tooltipContent 
]

{ #category : 't - element with tooltip - accessing' }
TToElementWithTooltip >> tooltip: anElement [

	self tooltipContent: anElement
]

{ #category : 't - element with tooltip - accessing' }
TToElementWithTooltip >> tooltipContent [

	^ self userData at: #tooltip ifAbsent: [  ]
]

{ #category : 't - element with tooltip - accessing' }
TToElementWithTooltip >> tooltipContent: anElement [

	anElement ifNil: [
		self privateRemoveTooltipWindowHandler.
		self userData removeKey: #tooltip ifAbsent: [  ].
		^ self ].
	self userData at: #tooltip put: anElement.
	self tooltipWindowHandler: ToTooltipWindowHandler new.
	self tooltipWindowHandler builder: [ :win :element | win content: anElement ]
]

{ #category : 't - element with tooltip - accessing' }
TToElementWithTooltip >> tooltipString: aString [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self tooltipText: aString asRopedText
]

{ #category : 't - element with tooltip - accessing' }
TToElementWithTooltip >> tooltipText: aText [

	self tooltipContent: ((ToLabel text: aText asRopedText)
			 beMultiLine;
			 yourself)
]

{ #category : 't - element with tooltip - accessing' }
TToElementWithTooltip >> tooltipWindowHandler [

	^ self userData at: #tooltipWindowHandler ifAbsent: [  ]
]

{ #category : 't - element with tooltip - accessing' }
TToElementWithTooltip >> tooltipWindowHandler: aWindowHandler [

	self tooltipWindowHandler = aWindowHandler ifTrue: [ ^ self ].
	self privateRemoveTooltipWindowHandler.
	aWindowHandler ifNil: [ ^ self ].
	self userData at: #tooltipWindowHandler put: (aWindowHandler
			 element: self;
			 yourself)
]
