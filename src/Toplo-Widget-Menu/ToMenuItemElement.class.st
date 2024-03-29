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

{ #category : #testing }
ToMenuItemElement >> closeOnMouseEvent [

	^ false
]

{ #category : #'adding-removing' }
ToMenuItemElement >> closeSiblingMenuWindow [

	self parentMenu ifNil: [ ^ self ].
	self parentMenu items do: [ :it |
		it menuWindowDo: [ :w | w isOpened ifTrue: [ w close ] ] ]
]

{ #category : #'menu window' }
ToMenuItemElement >> closeWindow [
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
	self addEventHandler: self defaultEventHandler.
	self initializeWithMenuItemConstraints

]

{ #category : #initialization }
ToMenuItemElement >> initializeWithMenuItemConstraints [ 

	self hMatchParent.
	self vFitContent.

]

{ #category : #testing }
ToMenuItemElement >> isMenu [

	^ false
]

{ #category : #'menu window' }
ToMenuItemElement >> isOpened [

	^ false

	
]

{ #category : #testing }
ToMenuItemElement >> isSubmenu [ 

	^ false
]

{ #category : #testing }
ToMenuItemElement >> isTopMenu [

	^ false
]

{ #category : #'menu window' }
ToMenuItemElement >> menuWindowDo: aValuable [
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
ToMenuItemElement >> parentMenuDo: aBlock [

	self parentMenu ifNil: [ ^ self ].
	aBlock value: self parentMenu
]

{ #category : #'adding-removing' }
ToMenuItemElement >> removedFromMenu: aMenu [

	self parentMenu: nil
]

{ #category : #'parent menu' }
ToMenuItemElement >> rootMenu [

	 ^ parentMenu ifNil: [ self ] ifNotNil: [ :pm | pm rootMenu  ]
]
