Trait {
	#name : #TToMenuItemBar,
	#instVars : [
		'menuBarOwner'
	],
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #'t - menu item bar  - accessing' }
TToMenuItemBar >> menuBarOwner [

	^ menuBarOwner
]

{ #category : #'t - menu item bar  - accessing' }
TToMenuItemBar >> menuBarOwner: aBarOwner [

	menuBarOwner ifNotNil: [ BlImmutableObjectChangeError signal ].
	menuBarOwner := aBarOwner
]
