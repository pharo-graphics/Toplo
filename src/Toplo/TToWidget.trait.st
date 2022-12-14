Trait {
	#name : #TToWidget,
	#traits : 'TBlAnnouncerProvider + TObservable + TToEnableable',
	#classTraits : 'TBlAnnouncerProvider classTrait + TObservable classTrait + TToEnableable classTrait',
	#category : #'Toplo-Core'
}

{ #category : #'t - initialization' }
TToWidget >> defaultLayout [

	^ BlLinearLayout horizontal 
]

{ #category : #'t - private - compagnon  events' }
TToWidget >> whenActionRequired: anActionRequiredFromCompagnon [

	anActionRequiredFromCompagnon value: self
]
