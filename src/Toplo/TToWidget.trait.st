Trait {
	#name : #TToWidget,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#category : 'Toplo-Core'
}

{ #category : #'t - widget - initialization' }
TToWidget >> defaultLayout [

	^ BlLinearLayout horizontal 
]

{ #category : #'t - widget - private - compagnon  events' }
TToWidget >> whenActionRequired: anActionRequiredFromCompagnon [

	anActionRequiredFromCompagnon value: self
]
