Trait {
	#name : #TToMenuItem,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - menu item' }
TToMenuItem >> isMenuItem [ 

	^ true
]

{ #category : #'t - menu item' }
TToMenuItem >> isSubmenu [ 

	^ false
]

{ #category : #'t - menu item' }
TToMenuItem >> parentMenu [

	self parentItemListHolder ifNil: [ ^ nil ].
	self parentItemListHolder isMenuBar ifTrue: [ ^ nil ].
	^ self parentItemListHolder
]

{ #category : #'t - menu item' }
TToMenuItem >> parentMenuDo: aBlock [

	self parentMenu ifNotNil: [ :p | aBlock value: p ]
]
