Trait {
	#name : #TToElementWithTooltip,
	#category : 'Toplo-Core'
}

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> closeTooltipWindowOnMouseLeave [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	^ self userData at: #closeTooltipWindowOnMouseLeave ifAbsentPut: [ true ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> closeTooltipWindowOnMouseLeave: aBoolean [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self userData at: #closeTooltipWindowOnMouseLeave put: aBoolean
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> currentTooltipWindow [

	^ self rawTooltipWindowHandler ifNotNil: [ :h | h currentWindow ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> hasOpenedTooltip [
	" do not use #tooltipWindowHandler to avoid TooltipWindowHandler installation here "

	^ self currentTooltipWindow notNil
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> hasTooltip [
	" do not use #tooltipWindowHandler to avoid TooltipWindowHandler installation here "

	^ self rawTooltipWindowHandler notNil
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> newTooltipWindowEvent: anEvent [

	^ self rawTooltipWindowHandler newWindowEvent: anEvent
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> rawTooltipWindowHandler [

	^ self userData at: #tooltipWindowHandler ifAbsent: [ ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> removeTooltip [

	self removeTooltipWindowHandler
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> removeTooltipWindowHandler [

	| tmp1 |
	tmp1 := self rawTooltipWindowHandler.
	tmp1 ifNil: [ ^ self ] ifNotNil: [ tmp1 ].
	tmp1 hasWindow ifTrue: [ tmp1 closeWindow ].
	tmp1 element: nil.
	self userData removeKey: #tooltipWindowHandler
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltip: aValuable [
	" aValuable take the window to build as first argument and the element with tooltip as second argument. if aValuable is nil, then the context menu builder is removed"

	self tooltipBuilder: aValuable
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipBuilder [

	^ self tooltipWindowHandler builder
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipBuilder: aValuable [

	" aValuable take the tooltip window to build as first argument and the element with tooltip as second argument "
	
	aValuable 
		ifNil: [
			self tooltipWindowHandler: nil.
			^ self ].
	self tooltipWindowHandler builder: aValuable
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipContent: anElement [

	anElement ifNil: [
		self removeTooltipWindowHandler.
		^ self ].
	self tooltipBuilder: [ :win :element | win root addChild: anElement ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipString: aString [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self tooltipText: aString asRopedText
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipText: aText [

	self tooltipContent: ((ToLabel text: aText asRopedText)
			 beMultiLine;
			 yourself)
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipWindowHandler [

	^ self userData at: #tooltipWindowHandler ifAbsentPut: [
		  | handler |
		  handler := ToTooltipWindowHandler new.
		  handler
			  element: self;
			  yourself ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipWindowHandler: aWindowHandler [

	self rawTooltipWindowHandler = aWindowHandler ifTrue: [ ^ self ].
	self removeTooltipWindowHandler.
	aWindowHandler ifNil: [ ^ self ].
	self userData at: #tooltipWindowHandler put: (aWindowHandler
			 element: self;
			 yourself)
]
