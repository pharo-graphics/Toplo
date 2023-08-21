Trait {
	#name : #TToMenuWindowModel,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - menu window model - window opening/closing' }
TToMenuWindowModel >> close [

	^ self explicitRequirement
]

{ #category : #'t - menu window model - testing' }
TToMenuWindowModel >> isSubmenu [

	^ false
]

{ #category : #'t - menu window model - accessing' }
TToMenuWindowModel >> menuWindow [

	^ self explicitRequirement 
]

{ #category : #'t - menu window model - window opening/closing' }
TToMenuWindowModel >> popupEvent: anEvent [

	^ self explicitRequirement
]
