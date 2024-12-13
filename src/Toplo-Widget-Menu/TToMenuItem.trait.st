Trait {
	#name : #TToMenuItem,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - menu item' }
TToMenuItem >> builder: aBlock [

	self
		deprecated: 'Use #itemBuilder'
		transformWith:
		'`@rcvr builder: `@arg' -> '`@rcvr itemBuilder: `@arg'.
	self itemBuilder: aBlock
]

{ #category : #'t - menu item' }
TToMenuItem >> isMenuItem [ 

	^ true
]

{ #category : #'t - menu item' }
TToMenuItem >> isSubmenu [ 

	^ false
]

{ #category : #'t - menu item' }
TToMenuItem >> parentMenuDo: aBlock [

	self parentItemListHolder ifNil: [ ^ self ].
	self parentItemListHolder isMenuBar ifTrue: [ ^ self ].
	aBlock value: self parentItemListHolder
]
