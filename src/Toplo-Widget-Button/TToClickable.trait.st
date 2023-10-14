Trait {
	#name : 'TToClickable',
	#category : 'Toplo-Widget-Button-Core',
	#package : 'Toplo-Widget-Button',
	#tag : 'Core'
}

{ #category : 't - clickable - click behavior' }
TToClickable >> clickEventClass [

	^ self userData at: #clickEventClass ifAbsentPut: [ BlPrimaryClickEvent ]
]

{ #category : 't - clickable - click behavior' }
TToClickable >> clickEventClass: anEventClass [

	^ self userData at: #clickEventClass put: anEventClass
]

{ #category : 't - clickable - click behavior' }
TToClickable >> clickHandler [

	^ self userData at: #clickHandler ifAbsent: [  ]
]

{ #category : 't - clickable - click behavior' }
TToClickable >> clickHandler: anEventHandler [

	self userData at: #clickHandler put: anEventHandler
]

{ #category : 't - clickable - click behavior' }
TToClickable >> removeClickHandler [
	"remove the click action"

	self clickHandler ifNotNil: [ :ch |
		self removeEventHandler: ch.
		self userData removeKey: #clickHandler ]
]

{ #category : 't - clickable - click behavior' }
TToClickable >> whenClickedDo: aBlock [
	"Inform that the widget has been clicked."

	" only one official handler "
	self removeClickHandler.
	self clickHandler: (BlEventHandler
			 on: self clickEventClass
			 do: [ :event | aBlock cull: event ]).
	self addEventHandler: self clickHandler
]
