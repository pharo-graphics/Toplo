Trait {
	#name : #TToMenuWindowModel,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - menu window model' }
TToMenuWindowModel >> closeWindow [

	^ self explicitRequirement 
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> isOpened [

	^ self explicitRequirement 
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> isSubmenu [

	^ self explicitRequirement 
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> isTopMenu [

	^ self explicitRequirement 
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> menuWindow [

	^ self explicitRequirement 
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> menuWindowDo: aValuable [

	self menuWindow ifNil: [ ^ self ].
	aValuable value: self menuWindow
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> popupEvent: anEvent [

	^ self explicitRequirement 
]
