Trait {
	#name : #TToElementWithTooltip,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'t - widget with tooltip - private' }
TToElementWithTooltip >> currentTooltipWindow [

	^ self currentAssociateWindow 
]

{ #category : #'t - widget with tooltip - testing' }
TToElementWithTooltip >> hasTooltip [

	^ self privateTooltipContent notNil
]

{ #category : #'t - widget with tooltip - private' }
TToElementWithTooltip >> newTooltipWindow [

	^ self newAssociateWindow 
]

{ #category : #'t - widget with tooltip - accessing' }
TToElementWithTooltip >> privateTooltipContent [

	^ self userData at: #tooltipContent ifAbsent: [  ]
]

{ #category : #'t - widget with tooltip - accessing' }
TToElementWithTooltip >> privateTooltipContent: anElement [

	anElement ifNil: [
		self userData removeKey: #tooltipContent ifAbsent: [  ].
		^ self ].
	self userData at: #tooltipContent put: anElement
]

{ #category : #'t - widget with tooltip - private' }
TToElementWithTooltip >> privateTooltipWindowDo: aBlock [

	self currentTooltipWindow
		ifNotNil: [ :tooltip | aBlock value: tooltip ]
]

{ #category : #'t - widget with tooltip - accessing' }
TToElementWithTooltip >> removeTooltip [

	self currentTooltipWindow ifNotNil: [ :w | self dissociateFromWindow ].
	self tooltipContent: nil
]

{ #category : #'t - widget with tooltip - accessing' }
TToElementWithTooltip >> tooltipContent [

	^ self privateTooltipContent 
]

{ #category : #'t - widget with tooltip - accessing' }
TToElementWithTooltip >> tooltipContent: anElement [

	self privateTooltipContent: anElement.
	anElement ifNil: [
		self associateWindowFactory: nil.
		^ self ].
	self associateWindowFactory: [ | win | win := ToTooltipWindow new.
		win content: anElement.
		win ].
	self addEventHandler: ToElementWithTooltipEventHandler new
]

{ #category : #'t - widget with tooltip - accessing' }
TToElementWithTooltip >> tooltipString: aString [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self tooltipText: aString asRopedText
]

{ #category : #'t - widget with tooltip - accessing' }
TToElementWithTooltip >> tooltipText: aText [

	self tooltipContent: ((ToLabel text: aText asRopedText)
			 beMultiLine;
			 yourself)
]
