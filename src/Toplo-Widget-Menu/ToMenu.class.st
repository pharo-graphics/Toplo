Class {
	#name : #ToMenu,
	#superclass : #ToMenuItem,
	#traits : 'TToItemListHolder + TToMenuItemListHolder + TToMenuWindowModel',
	#classTraits : 'TToItemListHolder classTrait + TToMenuItemListHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'isSubmenu',
		'builder',
		'windowManager'
	],
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #accessing }
ToMenu >> bar [

	self
		deprecated: 'Use #itemList instead'
		transformWith: '`@rcvr bar' -> '`@rcvr itemList'.

	^ self itemList
]

{ #category : #testing }
ToMenu >> beInline [

	self manager beInline
]

{ #category : #accessing }
ToMenu >> builder [ 

	^ builder
]

{ #category : #accessing }
ToMenu >> builder: aValuable [

	" aValuable takes myself and the request event as arguments "

	builder := aValuable
]

{ #category : #accessing }
ToMenu >> buttonClickEventClass [

	^ BlMouseDownEvent
]

{ #category : #'t - menu window model' }
ToMenu >> closeWindow [

	self menuWindow ifNotNil: [:mw | mw close ].

]

{ #category : #accessing }
ToMenu >> includes: anElement [

	self menuWindow = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ super includes: anElement
]

{ #category : #initialization }
ToMenu >> initialize [

	super initialize.
	self fitContent.
	isSubmenu := false.
	self applySkinInstallerOnFirstRequest: true.

	windowManager := ToMenuWindowManager new
		                 windowBuilder: [ :window :request |
			                 builder ifNotNil: [
					                 self removeAllItems.
					                 self builder cull: self cull: request ].
			                 window root addChild: self itemList ];
		                 yourself.
	self addEventHandler: windowManager
]

{ #category : #testing }
ToMenu >> isInline [

	^ self manager isInline
]

{ #category : #accessing }
ToMenu >> isMenu [

	^ true
]

{ #category : #'t - menu window model' }
ToMenu >> isOpened [ 

	^ self menuWindow notNil and: [ self menuWindow isOpened ]
]

{ #category : #'t - menu window model' }
ToMenu >> isSubmenu [

	^ isSubmenu
]

{ #category : #accessing }
ToMenu >> isSubmenu: aBoolean [

	isSubmenu := aBoolean
]

{ #category : #'t - menu window model' }
ToMenu >> isTopMenu [

	^ self isSubmenu not
]

{ #category : #accessing }
ToMenu >> manager [ 

	^ windowManager 
]

{ #category : #'t - menu window model' }
ToMenu >> menuWindow [

	^ self manager currentWindow
]

{ #category : #'event handling' }
ToMenu >> mouseLeaveEvent: anEvent [

	self itemList secondarySelecter deselectAll
]

{ #category : #'event handling' }
ToMenu >> mouseOverEvent: anEvent [

	(anEvent target hasInParentChain: self)
		ifTrue: [ self menuWindow ifNil: [ self popupEvent: anEvent ] ]
		ifFalse: [ self closeWindow ]
]

{ #category : #'t - item list holder - accessing' }
ToMenu >> newItemList [

	^ ToMenuItemListElement new
]

{ #category : #accessing }
ToMenu >> newRawSkin [ 

	^ ToMenuSkin new
]

{ #category : #'adding-removing' }
ToMenu >> onAddedInItemListHolder: aMenu [

	aMenu onAddedMenu: self
]

{ #category : #'adding-removing' }
ToMenu >> onRemovedFromItemListHolder: aMenu [

	aMenu onRemovedMenu: self
]

{ #category : #'t - menu window model' }
ToMenu >> popupEvent: anEvent [

	self manager popupEvent: anEvent
]

{ #category : #accessing }
ToMenu >> windowManager [

	self
		deprecated: 'Use #manager instead'
		transformWith: '`@rcvr windowManager' -> '`@rcvr manager'.
	^ self manager
]
