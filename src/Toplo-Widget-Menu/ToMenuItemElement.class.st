Class {
	#name : #ToMenuItemElement,
	#superclass : #ToItemElement,
	#traits : 'TToMenuItem',
	#classTraits : 'TToMenuItem classTrait',
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #testing }
ToMenuItemElement >> closeOnMouseEvent [

	^ false
]

{ #category : #'adding-removing' }
ToMenuItemElement >> closeSiblingMenuWindow [

	self parentItemListHolder ifNil: [ ^ self ].
	self parentItemListHolder closeAllWindowsForItemsSatisfying: [ :it | it ~= self ]
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> closeWindow [

]

{ #category : #initialization }
ToMenuItemElement >> constraintMenuNode: aNode [
	" Sent to let any menu item to adapt its resizer/layout  constraints before the node is added in the menu list. Notice that I am sent before the node adding + the selections shift is actually finished. Thus, this place is not adequate for changing one of the list selections (use #addedInMenu for that) "

	aNode holder listElement isHorizontal
		ifTrue: [ self hFitContent ]
		ifFalse: [ self hMatchParent ].
	self vFitContent
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
	self addEventHandler: self defaultEventHandler
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> isOpened [

	^ false

	
]

{ #category : #testing }
ToMenuItemElement >> isRootMenuItem [ 

	^ self parentItemListHolder isNil  or: [ self parentItemListHolder isMenuBar ]
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> isTopMenu [

	^ false
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> menuBar [

	self parentItemListHolder ifNil: [ ^ nil ].
	^ self parentItemListHolder menuBar
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> menuBarDo: aBlock [

	| mb |
	mb := self menuBar ifNil: [ ^ self ].
	aBlock value: mb
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> menuWindowDo: aValuable [
]

{ #category : #'adding-removing' }
ToMenuItemElement >> onAddedInItemListHolder: aMenu [

	aMenu onAddedMenuItem: self
]

{ #category : #'adding-removing' }
ToMenuItemElement >> onRemovedFromItemListHolder: aMenu [

	aMenu onRemovedMenuItem: self
]

{ #category : #'adding-removing' }
ToMenuItemElement >> removedFromMenu: aMenu [

	super removedFromMenu: aMenu.
	self parentItemListHolder: nil
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> rootMenu [

	self parentItemListHolder ifNil: [ ^ self ].
	self parentItemListHolder isMenuBar ifTrue: [ 
		^ self isMenu ifTrue: [ self ] ifFalse: [  ] ].
	^ self parentItemListHolder rootMenu
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> rootMenuDo: aBlock [

	| rm |
	rm := self rootMenu ifNil: [ ^ self ].
	aBlock value: rm
]
