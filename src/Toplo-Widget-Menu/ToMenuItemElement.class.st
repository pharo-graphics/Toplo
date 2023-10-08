Class {
	#name : #ToMenuItemElement,
	#superclass : #ToElement,
	#instVars : [
		'parentMenu'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding-removing' }
ToMenuItemElement >> addedInMenu: aMenu [

	self parentMenu: aMenu
]

{ #category : #accessing }
ToMenuItemElement >> associateWindow [

	^ nil
]

{ #category : #initialization }
ToMenuItemElement >> defaultEventHandler [

	^ self defaultEventHandlerClass new
]

{ #category : #initialization }
ToMenuItemElement >> defaultEventHandlerClass [ 

	^ ToMenuItemEventHandler
]

{ #category : #testing }
ToMenuItemElement >> hasIcon [

	^ false
]

{ #category : #testing }
ToMenuItemElement >> includes: anElement [

	self allChildrenBreadthFirstDo: [ :e | e = anElement ifTrue: [ ^ true ] ].
	^ false

]

{ #category : #initialization }
ToMenuItemElement >> initialize [

	super initialize.
	self layout: BlLinearLayout horizontal.
	self addEventHandler: self defaultEventHandler 
]

{ #category : #testing }
ToMenuItemElement >> isSubmenu [ 

	^ false
]

{ #category : #testing }
ToMenuItemElement >> isTopMenu [

	^ false
]

{ #category : #'parent menu' }
ToMenuItemElement >> parentMenu [

	 ^ parentMenu
]

{ #category : #'parent menu' }
ToMenuItemElement >> parentMenu: aMenu [

	parentMenu := aMenu
]

{ #category : #'parent menu' }
ToMenuItemElement >> parentMenuWindow [

	^ parentMenu ifNotNil: [:m | m associateWindow ] 
]

{ #category : #'adding-removing' }
ToMenuItemElement >> removedFromMenu: aMenu [

	self parentMenu: nil
]

{ #category : #'parent menu' }
ToMenuItemElement >> rootMenu [

	 ^ parentMenu ifNil: [ self ] ifNotNil: [ :pm | pm rootMenu  ]
]
