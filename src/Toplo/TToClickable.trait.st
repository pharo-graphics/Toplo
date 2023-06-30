Trait {
	#name : #TToClickable,
	#instVars : [
		'clickHandler'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - click behavior' }
TToClickable >> clickEventClass [

	^ BlPrimaryClickEvent 
]

{ #category : #'t - click behavior' }
TToClickable >> clickTargetFromEvent: anEvent [

	^ anEvent currentTarget
]

{ #category : #'t - click behavior' }
TToClickable >> client [

	^ self explicitRequirement 
]

{ #category : #'t - click behavior' }
TToClickable >> manageAction: aBlock onClickEvent: anEvent [

	aBlock
		cull: anEvent
		cull: self client
		cull: (self clickTargetFromEvent: anEvent)
]

{ #category : #'t - click behavior' }
TToClickable >> removeClickHandler [
	"remove the click action"

	clickHandler ifNotNil: [
		self removeEventHandler: clickHandler.
		clickHandler := nil ]
]

{ #category : #'t - click behavior' }
TToClickable >> whenClickedDo: aBlock [
	"Inform that the widget has been clicked."
	
	" only one official handler "
	self removeClickHandler.
	clickHandler := BlEventHandler
		                on: self clickEventClass
		                do: [ :event | self manageAction: aBlock onClickEvent: event ].
	self addEventHandler: clickHandler
]
