Trait {
	#name : #TToMenuWindowModel,
	#category : #'Toplo-Widget-Menu-Window'
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
			child parent isFake ifFalse: [ aValuable value: child ] ] ]
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> collectedNodes [

	^ Array streamContents: [ :stream |
		  self collectedNodesDo: [ :child | stream nextPut: child ] ]
]

{ #category : #'t - menu window model' }
TToMenuWindowModel >> collectedNodesDo: aValuable [

	self menuWindow allChildrenBreadthFirstDo: [ :child |
		(child isKindOf: ToMenuItemNode) ifTrue: [
			child isFake ifFalse: [ aValuable value: child ] ] ]
]

{ #category : #testing }
TToMenuWindowModel >> isInline [

	^ self windowManager isInline
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
