Trait {
	#name : #TToMenuItem,
	#instVars : [
		'parentItemContainer'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #testing }
TToMenuItem >> isMenuItem [ 

	^ true
]

{ #category : #testing }
TToMenuItem >> isSubmenu [ 

	^ false
]

{ #category : #accessing }
TToMenuItem >> parentItemContainer [

	^ parentItemContainer
]

{ #category : #accessing }
TToMenuItem >> parentItemContainer: anItemContainer [

	parentItemContainer := anItemContainer
]

{ #category : #parent }
TToMenuItem >> parentItemContainerDo: aBlock [

	parentItemContainer ifNil: [ ^ self ].
	aBlock value: parentItemContainer
]

{ #category : #parent }
TToMenuItem >> parentMenuDo: aBlock [

	parentItemContainer ifNil: [ ^ self ].
	parentItemContainer isMenuBar ifTrue: [ ^ self ].
	aBlock value: parentItemContainer
]

{ #category : #accessing }
TToMenuItem >> positionInItemContainer [

	self parentItemContainerDo: [ :pm | ^ pm items indexOf: self ].
	^ 0
]
