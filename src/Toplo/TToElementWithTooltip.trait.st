Trait {
	#name : #TToElementWithTooltip,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> currentTooltipWindow [

	^ self rawTooltipWindowManager ifNotNil: [ :h | h currentWindow ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> hasTooltip [
	" do not use #tooltipWindowHandler to avoid TooltipWindowHandler installation here "

	^ self rawTooltipWindowManager notNil
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

	^ self tooltipWindowManager windowBuilder
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipBuilder: aValuable [
	" aValuable take the tooltip window to build as first argument and the request event as second argument "

	aValuable ifNil: [
		self removeTooltipWindowManager.
		^ self ].
	self tooltipWindowManager windowBuilder: aValuable
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipContent: anElement [

	anElement ifNil: [
		self removeTooltipWindowManager.
		^ self ].
	self tooltipBuilder: [ :win :requestEventt | win root addChild: anElement ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipManagerDo: aValuable [

	aValuable value: self tooltipWindowManager 
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
		  handler := ToTooltipPopupManager new.
		  self addEventHandler: handler.
		  handler ]
]
