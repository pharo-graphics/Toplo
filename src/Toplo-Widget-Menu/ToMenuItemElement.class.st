"
I'm a data item for menu item list.
"
Class {
	#name : #ToMenuItemElement,
	#superclass : #ToListItem,
	#traits : 'TToMenuItem',
	#classTraits : 'TToMenuItem classTrait',
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #configuration }
ToMenuItemElement >> applyConfiguration [

	super applyConfiguration.
	self vFitContent
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
	self closeOnPicking: true.
	self addEventHandler: self defaultEventHandler.
	self constraintsDo: [ :c | c linear vertical alignCenter ]
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

{ #category : #testing }
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

{ #category : #'event handling' }
ToMenuItemElement >> onOutsideEvent: anEvent [

	self isInline ifTrue: [ ^ self ].
	self menuPaneDo: [ :mb | mb cancelAutoOpen ]
]

{ #category : #'adding-removing' }
ToMenuItemElement >> onRemovedFromItemBarOwner: aMenu [

	aMenu onRemovedMenuItem: self
]

{ #category : #'t - anchored window element - displaying' }
ToMenuItemElement >> popupEvent: anEvent [
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> rootMenu [

	(self menuListOwner isNil or: [ self menuListOwner isMenuPane ]) ifTrue: [
		^ self isMenu
			  ifTrue: [ self ]
			  ifFalse: [  ] ].
	^ self menuListOwner rootMenu
]

{ #category : #'t - menu window model' }
ToMenuItemElement >> rootMenuDo: aBlock [

	| rm |
	rm := self rootMenu ifNil: [ ^ self ].
	aBlock value: rm
]
