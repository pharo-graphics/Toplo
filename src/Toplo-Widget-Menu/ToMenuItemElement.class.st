"
I'm a data item for menu item list.
"
Class {
	#name : #ToMenuItemElement,
	#superclass : #ToBarItem,
	#traits : 'TToMenuItem',
	#classTraits : 'TToMenuItem classTrait',
	#instVars : [
		'closeOnPicking'
	],
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #configuration }
ToMenuItemElement >> applyConfiguration [
	" Sent to let any menu item to adapt its resizer/layout  constraints before the node is added in the menu list. Notice that I am sent before the node adding + the selections shift is actually finished. Thus, this place is not adequate for changing one of the list selections (use #addedInMenu for that) "

	super applyConfiguration.
	self holderDo: [ :h |
		h node fitContent.
		h listElement isHorizontal
			ifTrue: [
				self hFitContent ]
			ifFalse: [
				self hMatchParent ] ].
	self vFitContent
]

{ #category : #'t - menu item' }
ToMenuItemElement >> closeOnPicking [ 

	^ closeOnPicking 
]

{ #category : #testing }
ToMenuItemElement >> closeOnPicking: aBoolean [

	closeOnPicking := aBoolean
]

{ #category : #'t - menu window model' }
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

{ #category : #initialization }
ToMenuItemElement >> defaultLayout [

	^ BlLinearLayout horizontal
]

{ #category : #testing }
ToMenuItemElement >> hasIcon [

	^ false
]

{ #category : #testing }
ToMenuItemElement >> hasInlineWindow [

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
	closeOnPicking := true.
	self addEventHandler: self defaultEventHandler.
	self constraintsDo: [ :c | c linear vertical alignCenter ]
]

{ #category : #accessing }
ToMenuItemElement >> inlineWindowLevel [

	| l |
	l := 0.
	self withAllParentsDo: [ :p |
		(p isKindOf: ToMenuInlineWindowElement) ifTrue: [ l := l + 1 ] ].
	^ l
]

{ #category : #testing }
ToMenuItemElement >> isInline [

	^ false
]

{ #category : #testing }
ToMenuItemElement >> isMenuButton [

	^ true
]

{ #category : #testing }
ToMenuItemElement >> isMenuPaneMenu [

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
ToMenuItemElement >> menuPaneDo: aBlock [

	| mb |
	mb := self menuPane ifNil: [ ^ self ].
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
ToMenuItemElement >> onAddedInItemBarOwner: aMenu [

	aMenu onAddedMenuItem: self
]

{ #category : #'adding-removing' }
ToMenuItemElement >> onRemovedFromItemBarOwner: aMenu [

	aMenu onRemovedMenuItem: self
]

{ #category : #accessing }
ToMenuItemElement >> openOnHovered [

	^ false
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> rootMenu [

	(self menuBarOwner isNil or: [ self menuBarOwner isMenuPane ]) ifTrue: [
		^ self isMenu
			  ifTrue: [ self ]
			  ifFalse: [  ] ].
	^ self menuBarOwner rootMenu
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> rootMenuDo: aBlock [

	| rm |
	rm := self rootMenu ifNil: [ ^ self ].
	aBlock value: rm
]
