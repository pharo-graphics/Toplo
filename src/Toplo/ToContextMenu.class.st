Class {
	#name : #ToContextMenu,
	#superclass : #ToMenuWindow,
	#traits : 'TToMenuItemHolder',
	#classTraits : 'TToMenuItemHolder classTrait',
	#instVars : [
		'widgetWithContextMenuEventHandler'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - menu window accessing' }
ToContextMenu >> allParentMenusDo: aBlock [
]

{ #category : #'initialize-release' }
ToContextMenu >> close [

	self widget ifNotNil: [ :w | w openedContextMenu: nil. self widget requestFocus ].
	^ super close
]

{ #category : #initialization }
ToContextMenu >> initialize [

	self class initializeSlots: self.
	super initialize.
	self initializeMenuItemHolder.

]

{ #category : #initialization }
ToContextMenu >> openPositionFromEvent: anEvent [

	^ anEvent position
]

{ #category : #'api - displaying' }
ToContextMenu >> popupEvent: anEvent [

	self widget ifNotNil: [ :w | w openedContextMenu: self ].

	self requestFocus.
	super popupEvent: anEvent
]

{ #category : #'t - menu window accessing' }
ToContextMenu >> subMenuWindow [ 

	^ self
]
