Trait {
	#name : #TToElementWithTooltip,
	#category : #'Toplo-Core-Tooltip'
}

{ #category : #'t - widget with tooltip - testing' }
TToElementWithTooltip >> hasTooltip [

	^ self privateTooltipWindow notNil
]

{ #category : #'t - widget with tooltip - private' }
TToElementWithTooltip >> newTooltipWindow [

	^ self tooltipWindowClass new
		  associateElement: self;
		  yourself
]

{ #category : #'t - widget with tooltip - private' }
TToElementWithTooltip >> privateCheckTooltipWindowInstallation [

	self privateTooltipWindow ifNil: [ self privateInstallTooltipWindow ]
]

{ #category : #'t - widget with tooltip - private' }
TToElementWithTooltip >> privateInstallTooltipWindow [

	self privateTooltipWindow: self newTooltipWindow
]

{ #category : #'t - widget with tooltip - private' }
TToElementWithTooltip >> privateTooltipWindow [

	^ self userData at: #privateTooltipWindow ifAbsent: [  ]
]

{ #category : #'t - widget with tooltip - private' }
TToElementWithTooltip >> privateTooltipWindow: aTooltip [

	aTooltip ifNil: [
		self userData removeKey: #privateTooltipWindow.
		^ self ].
	self userData at: #privateTooltipWindow put: aTooltip
]

{ #category : #'t - widget with tooltip - private' }
TToElementWithTooltip >> privateTooltipWindowDo: aBlock [

	self privateTooltipWindow
		ifNotNil: [ :tooltip | aBlock value: tooltip ]
]

{ #category : #'t - widget with tooltip - private' }
TToElementWithTooltip >> removeTooltip [

	self privateTooltipWindowDo: [ :tooltip |
		tooltip removeWidget.
		self privateTooltipWindow: nil ]
]

{ #category : #'t - widget with tooltip - accessing' }
TToElementWithTooltip >> tooltipContent [

	^ self privateTooltipWindow ifNotNil: [ :ptw | ptw content ]
]

{ #category : #'t - widget with tooltip - accessing' }
TToElementWithTooltip >> tooltipContent: anElement [

	self hasTooltip ifTrue: [
		self tooltipContent = anElement ifTrue: [ ^ self ] ].
	anElement ifNil: [
		self removeTooltip.
		^ self ].
	self privateCheckTooltipWindowInstallation.
	self privateTooltipWindow content: anElement
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

{ #category : #'t - widget with tooltip - private' }
TToElementWithTooltip >> tooltipWindowClass [

	^ ToTooltipWindow 
]
