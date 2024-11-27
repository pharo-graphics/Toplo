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

	aMenu addedMenuItem: self
]

{ #category : #testing }
ToMenuItemElement >> closeOnMouseEvent [

	^ false
]

{ #category : #'friend only' }
ToMenuItemElement >> closeRequestFrom: anItem [

	self closeWindow
]

{ #category : #'adding-removing' }
ToMenuItemElement >> closeSiblingMenuWindow [

	self parentMenu ifNil: [ ^ self ].
	self parentMenu items do: [ :it |
		it = self ifFalse: [ it menuWindowDo: [ :w | w close ] ] ]
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
ToMenuItemElement >> isMenuItem [ 

	^ true
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> isOpened [

	^ false

	
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> isSubmenu [ 

	^ false
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> isTopMenu [

	^ false
]

{ #category : #'t - menu window model' }
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

{ #category : #accessing }
ToMenuItemElement >> positionInMenu [

	self parentMenuDo: [ :pm | ^ pm items indexOf: self ].
	^ 0
]

{ #category : #'adding-removing' }
ToMenuItemElement >> removedFromMenu: aMenu [

	super removedFromMenu: aMenu.
	self parentMenu: nil
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> rootMenu [

	| rm |
	parentMenu ifNil: [ ^ self ].
	rm := parentMenu rootMenu.
	^ rm isMenu
		  ifTrue: [ rm ]
		  ifFalse: [ self ]
]
