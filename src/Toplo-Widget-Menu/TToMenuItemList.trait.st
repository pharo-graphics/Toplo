Trait {
	#name : #TToMenuItemList,
	#instVars : [
		'menuListOwner'
	],
	#category : #'Toplo-Widget-Menu-ItemList'
}

{ #category : #'t - menu item list  - accessing' }
TToMenuItemList >> menuListOwner [

	^ menuListOwner
]

{ #category : #'t - menu item list  - accessing' }
TToMenuItemList >> menuListOwner: aListOwner [

	menuListOwner ifNotNil: [ BlImmutableObjectChangeError signal ].
	menuListOwner := aListOwner
]
