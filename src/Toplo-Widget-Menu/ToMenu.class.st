Class {
	#name : #ToMenu,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel + TToElementWithAssociateWindow',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait + TToElementWithAssociateWindow classTrait',
	#instVars : [
		'items',
		'isSubmenu',
		'associateWindow'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'adding-removing' }
ToMenu >> addedInMenu: aMenu [

	super addedInMenu: aMenu.
	isSubmenu := true.
	self initializeWithMenuItemConstraints

]

{ #category : #'t - menu window model - accessing' }
ToMenu >> associateWindow [

	^ associateWindow ifNil: [
		  associateWindow := ToMenuWindow new
			                associateElement: self;
			                yourself ]
]

{ #category : #accessing }
ToMenu >> associateWindow: aWindowElement [

	associateWindow := aWindowElement
]

{ #category : #'t - menu window model - window opening/closing' }
ToMenu >> close [

	^ self associateWindow close
]

{ #category : #testing }
ToMenu >> includes: anElement [

	self associateWindow = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ super includes: anElement
]

{ #category : #initialization }
ToMenu >> initialize [

	super initialize.
	isSubmenu := false.
	self initializeWithMenuConstraints
]

{ #category : #initialization }
ToMenu >> initializeWithMenuConstraints [

	self fitContent.

]

{ #category : #testing }
ToMenu >> isSubmenu [

	^ isSubmenu 
]

{ #category : #testing }
ToMenu >> isTopMenu [

	^ self parentMenu isNil
]

{ #category : #'t - menu item holder - accessing' }
ToMenu >> items [

	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #'t - menu window model - window opening/closing' }
ToMenu >> popupEvent: anEvent [

	^ self associateWindow popupEvent: anEvent
]

{ #category : #'adding-removing' }
ToMenu >> removedFromMenu: aMenu [

	super removedFromMenu: aMenu.
	isSubmenu := false.
	self initializeWithMenuConstraints 

	
]

{ #category : #'theme event handling' }
ToMenu >> toThemeChanged [ 

	super toThemeChanged.
	self window ifNotNil: [ :mw | mw toThemeChanged ]
	
]
