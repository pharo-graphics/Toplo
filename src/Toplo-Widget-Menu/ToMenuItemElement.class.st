Class {
	#name : #ToMenuItemElement,
	#superclass : #ToElement,
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

	parentItemContainer ifNil: [ ^ self ].
	parentItemContainer closeAllWindowsForItemsSatisfying: [ :it | it ~= self ]
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> closeWindow [

]

{ #category : #initialization }
ToMenuItemElement >> constraintMenuNode: aNode [
	" Sent to let any menu item to adapt its resizer/layout  constraints before the node is added in the menu list. Notice that I am sent before the node adding + the selections shift is actually finished. Thus, this place is not adequate for changing one of the list selections (use #addedInMenu for that) "

	aNode holder listElement isHorizontal
		ifTrue: [
			self constraintsDo: [ :c |
				c horizontal fitContent.
				c vertical fitContent ] ]
		ifFalse: [
			self constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical fitContent ] ]
]

{ #category : #initialization }
ToMenuItemElement >> defaultEventHandler [

	^ self defaultEventHandlerClass new
]

{ #category : #initialization }
ToMenuItemElement >> defaultEventHandlerClass [ 

	^ ToMenuItemEventHandler
]

{ #category : #initialization }
ToMenuItemElement >> defaultLayout [

	^ BlLinearLayout horizontal
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

	^ parentItemContainer isNil  or: [ parentItemContainer isMenuBar ]
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> isTopMenu [

	^ false
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> menuBar [

	parentItemContainer ifNil: [ ^ nil ].
	^ parentItemContainer menuBar
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
ToMenuItemElement >> onAddedInMenuItemContainer: aMenu [

	aMenu onAddedMenuItem: self
]

{ #category : #'adding-removing' }
ToMenuItemElement >> removedFromMenu: aMenu [

	super removedFromMenu: aMenu.
	self parentItemContainer: nil
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> rootMenu [

	parentItemContainer ifNil: [ ^ self ].
	parentItemContainer isMenuBar ifTrue: [ 
		^ self isMenu ifTrue: [ self ] ifFalse: [ nil ] ].
	^ parentItemContainer rootMenu
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> rootMenuDo: aBlock [

	| rm |
	rm := self rootMenu ifNil: [ ^ self ].
	aBlock value: rm
]
