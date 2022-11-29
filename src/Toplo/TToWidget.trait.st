Trait {
	#name : #TToWidget,
	#traits : 'TBlAnnouncerProvider + TToObservable + TOBlLayoutResizable',
	#classTraits : 'TBlAnnouncerProvider classTrait + TToObservable classTrait + TOBlLayoutResizable classTrait',
	#category : #'Toplo-Core'
}

{ #category : #'t - initialization' }
TToWidget >> defaultLayout [

	^ BlLinearLayout horizontal 
]

{ #category : #'t - world' }
TToWidget >> openInInnerWindow [

	| frame |
	frame := ToInnerWindow new.
	frame addChild: self.
	frame openInWorld
]

{ #category : #'t - world' }
TToWidget >> openInWorld [

	| world |
	world := ToManager world.
	world isOpened ifFalse: [ world show ].
	world root addChild: self
]

{ #category : #'t - private - compagnon  events' }
TToWidget >> whenActionRequired: anActionRequiredFromCompagnon [

	anActionRequiredFromCompagnon value: self
]
