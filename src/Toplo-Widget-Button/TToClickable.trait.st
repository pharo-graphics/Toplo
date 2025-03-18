Trait {
	#name : #TToClickable,
	#category : #'Toplo-Widget-Button-Core'
}

{ #category : #'t - clickable' }
TToClickable >> clickEvent: anEvent [
]

{ #category : #'t - clickable' }
TToClickable >> clickEventClass [

	^ self userData at: #clickEventClass ifAbsent: [ BlPrimaryClickEvent  ]
]

{ #category : #'t - clickable' }
TToClickable >> clickEventClass: anEventClass [

	anEventClass ifNil: [
		self userData removeKey: #clickEventClass.
		^ self ].
	self userData at: #clickEventClass put: anEventClass
]

{ #category : #'t - clickable' }
TToClickable >> initializeAsClickable [ 

	self addEventHandler: ToClickableFocusEventHandler new.
]

{ #category : #'t - clickable' }
TToClickable >> removeClickAction [
	"remove the click action"

	self
		deprecated: 'Use the action link #unlink feature instead'
]

{ #category : #'t - clickable' }
TToClickable >> removeClickHandler [
	"remove the click action"

	self
		deprecated: 'Use the action link #unlink feature instead'
]

{ #category : #'t - clickable' }
TToClickable >> takeFocusOnClick [

	^ false
]

{ #category : #'t - clickable' }
TToClickable >> whenClickedDo: aValuable [
	"Inform that the widget has been clicked."

	^ self newClickAction: aValuable
]
