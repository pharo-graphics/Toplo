Trait {
	#name : #TToWidget,
	#traits : 'TBlAnnouncerProvider + TToObservable + TToWidgetWithDresser + TToEnableable',
	#classTraits : 'TBlAnnouncerProvider classTrait + TToObservable classTrait + TToWidgetWithDresser classTrait + TToEnableable classTrait',
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
