Trait {
	#name : #TToClickable,
	#instVars : [
		'clickHandler'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - clickable - click behavior' }
TToClickable >> clickEventClass [

	^ BlPrimaryClickEvent 
]

{ #category : #'t - clickable - click behavior' }
TToClickable >> client [

	^ self explicitRequirement 
]

{ #category : #'t - clickable - click behavior' }
TToClickable >> manageAction: aBlock onClickEvent: anEvent [

	aBlock
		cull: anEvent
		cull: self client
		cull: anEvent currentTarget
]

{ #category : #'t - clickable - click behavior' }
TToClickable >> removeClickHandler [
	"remove the click action"

	clickHandler ifNotNil: [
		self removeEventHandler: clickHandler.
		clickHandler := nil ]
]

{ #category : #'t - clickable - click behavior' }
TToClickable >> whenClickedDo: aBlock [
	"Inform that the widget has been clicked."
	
	" only one official handler "
	self removeClickHandler.
	clickHandler := BlEventHandler
		                on: self clickEventClass
		                do: [ :event | self manageAction: aBlock onClickEvent: event ].
	self addEventHandler: clickHandler
]
