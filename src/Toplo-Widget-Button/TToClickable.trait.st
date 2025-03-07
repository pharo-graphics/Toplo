Trait {
	#name : #TToClickable,
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'t - clickable' }
TToClickable >> clickEvent: anEvent [
]

{ #category : #'t - clickable' }
TToClickable >> clickEventClass [

	^ self userData at: #clickEventClass ifAbsent: [ super clickEventClass ]
]

{ #category : #'t - clickable' }
TToClickable >> clickEventClass: anEventClass [

	anEventClass ifNil: [
		self userData removeKey: #clickEventClass.
		^ self ].
	self userData at: #clickEventClass put: anEventClass
]

{ #category : #'t - clickable' }
TToClickable >> clickHandler [

	^ self userData at: #clickHandler ifAbsent: [  ]
]

{ #category : #'t - clickable' }
TToClickable >> clickHandler: anEventHandler [

	anEventHandler ifNil: [
		self userData removeKey: #clickHandler.
		^ self ].
	self userData at: #clickHandler put: anEventHandler
]

{ #category : #'t - clickable' }
TToClickable >> newClickHandlerWith: aBlock [

	^ ToClickableActionEventHandler action: aBlock
]

{ #category : #'t - clickable' }
TToClickable >> removeClickHandler [
	"remove the click action"

	self clickHandler ifNotNil: [ :ch |
		self removeEventHandler: ch.
		self clickHandler: nil ]
]

{ #category : #'t - clickable' }
TToClickable >> takeFocusOnClick [

	^ false
]

{ #category : #'t - clickable' }
TToClickable >> whenClickedDo: aBlock [
	"Inform that the widget has been clicked."

	" only one official handler "
	self removeClickHandler.
	self clickHandler: (self newClickHandlerWith: aBlock).
	self addEventHandler: self clickHandler
]
