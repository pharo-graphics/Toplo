Trait {
	#name : #TToClickable,
	#category : #'Toplo-Widget-Button-Clickable'
}

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

	self addEventHandler: ToClickableEventHandler new.
]

{ #category : #'t - clickable' }
TToClickable >> takeFocusOnClick [

	^ false
]
