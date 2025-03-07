Trait {
	#name : #TToClickable,
	#instVars : [
		'clickAction'
	],
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'t - clickable' }
TToClickable >> clickAction: aValuable [

	clickAction ifNotNil: [ :ca | ca unlink ].
	clickAction := super clickAction: aValuable.
	^ clickAction
]

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
TToClickable >> removeClickAction [
	"remove the click action"

	clickAction ifNotNil: [ :ca |
		ca unlink.
		clickAction := nil ]
]

{ #category : #'t - clickable' }
TToClickable >> removeClickHandler [
	"remove the click action"

	self
		deprecated: 'Use #removeClickAction instead'
		transformWith:
		'`@rcvr removeClickHandler' -> '`@rcvr removeClickAction'.
	self removeClickAction
]

{ #category : #'t - clickable' }
TToClickable >> takeFocusOnClick [

	^ false
]

{ #category : #'t - clickable' }
TToClickable >> whenClickedDo: aBlock [
	"Inform that the widget has been clicked."

	^ self addEventHandlerOn: self clickEventClass do: aBlock
]
