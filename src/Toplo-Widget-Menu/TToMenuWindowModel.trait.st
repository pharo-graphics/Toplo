Trait {
	#name : #TToMenuWindowModel,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - menu window model' }
TToMenuWindowModel >> closeWindow [

	^ self explicitRequirement 
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> collectedItems [

	^ Array streamContents: [ :stream |
		  self collectedItemsDo: [ :child | stream nextPut: child ] ]
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> collectedItemsDo: aValuable [

	self menuWindow allChildrenBreadthFirstDo: [ :child |
		(child isKindOf: ToMenuItemElement) ifTrue: [
			aValuable value: child ] ]
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
