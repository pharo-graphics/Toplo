Trait {
	#name : #TToMenuItemBar,
	#category : #'Toplo-Widget-Menu-ItemBar'
}

{ #category : #'t - menu item bar  - accessing' }
TToMenuItemBar >> menuBarOwner [

	^ self userData at: #menuBarOwner ifAbsent: [  ]
]

{ #category : #'t - menu item bar  - accessing' }
TToMenuItemBar >> menuBarOwner: aBarOwner [

	self userData at: #menuBarOwner put: aBarOwner
]
