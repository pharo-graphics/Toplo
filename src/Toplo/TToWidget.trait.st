Trait {
	#name : #TToWidget,
	#traits : 'TBlAnnouncerProvider + TObservable',
	#classTraits : 'TBlAnnouncerProvider classTrait + TObservable classTrait',
	#category : #'Toplo-Core'
}

{ #category : #'t - initialization' }
TToWidget >> defaultLayout [

	^ BlLinearLayout horizontal 
]

{ #category : #initialization }
TToWidget >> initialize [

	self class initializeSlots: self.
	super initialize.
]

{ #category : #'t - private - compagnon  events' }
TToWidget >> whenActionRequired: anActionRequiredFromCompagnon [

	anActionRequiredFromCompagnon value: self
]
