Trait {
	#name : #TToMenuItem,
	#instVars : [
		'parentItemContainer'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #accessing }
TToMenuItem >> builder: aBlock [

	self
		deprecated: 'Use #itemBuilder'
		transformWith:
		'`@rcvr builder: `@arg' -> '`@rcvr itemBuilder: `@arg'.
	self itemBuilder: aBlock
]

{ #category : #testing }
TToMenuItem >> isMenuItem [ 

	^ true
]

{ #category : #testing }
TToMenuItem >> isSubmenu [ 

	^ false
]

{ #category : #accessing }
TToMenuItem >> itemBuilder: aBlock [

	self in: aBlock
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
