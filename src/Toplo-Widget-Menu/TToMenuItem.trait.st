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

{ #category : #'t - menu item' }
TToMenuItem >> parentItemContainer [

	^ parentItemContainer
]

{ #category : #'t - menu item' }
TToMenuItem >> parentItemContainer: anItemContainer [

	parentItemContainer := anItemContainer
]

{ #category : #'t - menu item' }
TToMenuItem >> parentItemContainerDo: aBlock [

	parentItemContainer ifNil: [ ^ self ].
	aBlock value: parentItemContainer
]

{ #category : #'t - menu item' }
TToMenuItem >> parentMenuDo: aBlock [

	parentItemContainer ifNil: [ ^ self ].
	parentItemContainer isMenuBar ifTrue: [ ^ self ].
	aBlock value: parentItemContainer
]

{ #category : #'t - menu item' }
TToMenuItem >> positionInItemContainer [

	self parentItemContainerDo: [ :pm | ^ pm items indexOf: self ].
	^ 0
]
