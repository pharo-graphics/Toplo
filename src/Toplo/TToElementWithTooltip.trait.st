Trait {
	#name : #TToElementWithTooltip,
	#category : #'Toplo-Core'
}

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> currentTooltipWindow [

	^ self rawTooltipManager ifNotNil: [ :h | h currentWindow ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> ensuredTooltipManager [

	^ self userData
		  at: #tooltipManager
		  ifAbsentPut: [ self installedNewTooltipManager ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> hasTooltip [
	" do not use #tooltipWindowHandler to avoid TooltipWindowHandler installation here "

	^ self rawTooltipManager notNil
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> installedNewTooltipManager [

	| h |
	self addEventHandler: (h := self tooltipManagerClass new).
	^ h
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> rawTooltipManager [

	^ self userData at: #tooltipManager ifAbsent: [ ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> removeTooltip [

	self removeTooltipManager
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> removeTooltipManager [

	| manager |
	manager := self rawTooltipManager.
	manager ifNil: [ ^ self ].
	manager currentWindowDo: [:cw | cw isOpened ifTrue: [ cw close ] ].
	self removeEventHandler: manager.
	self userData removeKey: #tooltipManager
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltip: aValuable [
	" aValuable take the window to build as first argument and the request event as second argument "

	self tooltipBuilder: aValuable
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipBuilder: aValuable [
	" aValuable take the tooltip window to build as first argument and the request event as second argument "

	self ensuredTooltipManager windowBuilder: aValuable
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipContent: anElement [

	self
		deprecated: 'Use #tooltipBuilder:'
		transformWith: '`@rcvr tooltipContent: `@arg'
			->
			'`@rcvr tooltipBuilder: [ :win :request | win root addChild: `@arg ]'.
	self tooltipBuilder: [ :win :request | win root addChild: anElement ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipManagerClass [

	^ ToTooltipManager
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipManagerDo: aValuable [

	aValuable value: self ensuredTooltipManager
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipString: aString [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self tooltipText: aString asRopedText
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipText: aText [

	self tooltipBuilder: [ :win :request |
			win root addChild: ((ToLabel text: aText asRopedText)
					 beMultiLine;
					 yourself) ]
]

{ #category : #'t - element with tooltip' }
TToElementWithTooltip >> tooltipWindowManager [

	self
		deprecated: 'Use #ensuredTooltipManager'
		transformWith:
		'`@rcvr tooltipWindowManager' -> '`@rcvr ensuredTooltipManager'.	

	^ self ensuredTooltipManager
]
