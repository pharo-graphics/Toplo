Trait {
	#name : #TToClickable,
	#category : #'Toplo-Core'
}

{ #category : #'t - click behavior' }
TToClickable >> clickTargetFromEvent: anEvent [

	^ anEvent currentTarget
]

{ #category : #'t - click behavior' }
TToClickable >> client [

	^ self explicitRequirement 
]

{ #category : #'t - click behavior' }
TToClickable >> whenClickedDo: aBlock [
	"Inform that the widget has been clicked."

	self when: BlClickEvent do: [ :event |
		aBlock
			cull: event
			cull: self client
			cull: (self clickTargetFromEvent: event) ]
]
