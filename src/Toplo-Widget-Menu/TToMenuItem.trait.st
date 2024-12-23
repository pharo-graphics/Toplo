Trait {
	#name : #TToMenuItem,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'t - menu item' }
TToMenuItem >> isInline [ 

	self parentMenuDo: [ :m | ^ m isInline ].
	^ false
]

{ #category : #'t - menu item' }
TToMenuItem >> isMenuItem [ 

	^ true
]

{ #category : #'t - menu item' }
TToMenuItem >> isRootMenuItem [ 

	^ self parentItemListHolder isNil  or: [ self parentItemListHolder isMenuBar ]
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

{ #category : #'t - menu item' }
TToMenuItem >> popupWindowParentMenu [

	| win |
	win := self firstInParentChainSatisfying: [ :p |
		       p isKindOf: ToMenuWindow ].
	win ifNotNil: [ ^ win itemContainer ].
	^ nil
]

{ #category : #'t - menu item' }
TToMenuItem >> popupWindowParentMenuDo: aBlock [

	self popupWindowParentMenu ifNotNil: [ :p | aBlock value: p ]
]
