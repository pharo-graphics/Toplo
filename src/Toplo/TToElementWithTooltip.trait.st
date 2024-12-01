Trait {
	#name : #TToElementWithTooltip,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> closeTooltipOnMouseLeave: aBoolean [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self tooltipWindowManager closeOnMouseLeave: aBoolean
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> currentTooltipWindow [

	^ self rawTooltipWindowManager ifNotNil: [ :h | h currentWindow ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> hasOpenedTooltip [
	" do not use #tooltipWindowHandler to avoid TooltipWindowHandler installation here "
	self deprecated: 'Unless there are users. add an issue if this is the case'.
	^ self currentTooltipWindow notNil
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> hasTooltip [
	" do not use #tooltipWindowHandler to avoid TooltipWindowHandler installation here "

	^ self rawTooltipWindowManager notNil
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> newTooltipWindowEvent: anEvent [

	^ self rawTooltipWindowManager newWindowEvent: anEvent
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> rawTooltipWindowManager [

	^ self userData at: #tooltipWindowManager ifAbsent: [ ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> removeTooltip [

	self removeTooltipWindowManager
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> removeTooltipWindowManager [

	| manager |
	manager := self rawTooltipWindowManager.
	manager ifNil: [ ^ self ].
	manager currentWindowDo: [:cw | cw isOpened ifTrue: [ cw close ] ].
	self removeEventHandler: manager.
	self userData removeKey: #tooltipWindowManager
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltip: aValuable [
	" aValuable take the window to build as first argument and the request event as second argument. if aValuable is nil, then the context menu builder is removed"

	self tooltipBuilder: aValuable
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipBuilder [

	^ self tooltipWindowManager builder
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipBuilder: aValuable [

	" aValuable take the tooltip window to build as first argument and the request event as second argument "
	
	aValuable 
		ifNil: [
			self removeTooltipWindowManager.
			^ self ].
	self tooltipWindowManager builder: aValuable
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipContent: anElement [

	anElement ifNil: [
		self removeTooltipWindowManager.
		^ self ].
	self tooltipBuilder: [ :win :requestEventt | win root addChild: anElement ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipPopupDelay [
	
	^ self userData at: #tooltipPopupDelay ifAbsent: [  ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipPopupDelay: aDuration [
	
	self userData at: #tooltipPopupDelay put: aDuration.
	self rawTooltipWindowManager ifNotNil: [ :h | h autoPopupDelay: aDuration ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipString: aString [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self tooltipText: aString asRopedText
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipText: aText [

	self tooltipContent: ((ToLabel text: aText asRopedText)
			 defaultRawSkin: ToLabelInTooltipSkin new;
			 beMultiLine;
			 yourself)
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipWindowManager [

	^ self userData at: #tooltipWindowManager ifAbsentPut: [
		  | handler |
		  handler := ToTooltipWindowManager new.
			" pay attention that the handler must be added before changing the delay "
		  self addEventHandler: handler.
		  self tooltipPopupDelay ifNotNil: [ :d | handler autoPopupDelay: d ].
		  handler ]
]
