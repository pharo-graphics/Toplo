Trait {
	#name : #TToMenuWindowModel,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - menu window model - window opening/closing' }
TToMenuWindowModel >> close [

	^ self explicitRequirement
]

{ #category : #'t - menu window model - accessing' }
TToMenuWindowModel >> menuWindow [

	^ self explicitRequirement 
]

{ #category : #'t - menu window model - window opening/closing' }
TToMenuWindowModel >> popupEvent: anEvent [

	^ self explicitRequirement
]
