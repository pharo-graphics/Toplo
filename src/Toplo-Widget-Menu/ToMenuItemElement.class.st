"
I'm a data item for menu item list.
"
Class {
	#name : #ToMenuItemElement,
	#superclass : #ToItemElement,
	#traits : 'TToMenuItem',
	#classTraits : 'TToMenuItem classTrait',
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'adding-removing' }
ToMenuItemElement >> closeSiblingMenuWindow [

	self barOwner ifNil: [ ^ self ].
	self barOwner closeAllWindowsForItemsSatisfying: [ :it |
		it notNil and: [
			it ~= self and: [ it isInline not ] ] ]
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
	self addEventHandler: self defaultEventHandler.
	self constraintsDo: [ :c | c linear vertical alignCenter ]
]

{ #category : #accessing }
ToMenuItemElement >> inlineWindowLevel [

	| l |
	l := 0.
	self withAllParentsDo: [ :p |
		(p isKindOf: ToInlineMenuWindowElement) ifTrue: [ l := l + 1 ] ].
	^ l
]

{ #category : #testing }
ToMenuItemElement >> isInline [

	^ false
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> isOpened [

	^ false

	
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> isTopMenu [

	^ false
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

{ #category : #skin }
ToMenuItemElement >> newRawSkin [

	^ ToMenuItemElementSkin new
]

{ #category : #'adding-removing' }
ToMenuItemElement >> onAddedInItemBar: aMenu [

	aMenu onAddedMenuItem: self
]

{ #category : #'adding-removing' }
ToMenuItemElement >> onRemovedFromItemBar: aMenu [

	aMenu onRemovedMenuItem: self
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> rootMenu [

	self barOwner ifNil: [ ^ self ].
	self barOwner isMenuBar ifTrue: [ 
		^ self isMenu ifTrue: [ self ] ifFalse: [  ] ].
	^ self barOwner rootMenu
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> rootMenuDo: aBlock [

	| rm |
	rm := self rootMenu ifNil: [ ^ self ].
	aBlock value: rm
]
