Trait {
	#name : #TToWidget,
	#traits : 'TBlAnnouncerProvider + TToObservable',
	#classTraits : 'TBlAnnouncerProvider classTrait + TToObservable classTrait',
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
