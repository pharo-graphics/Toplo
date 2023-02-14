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

{ #category : #'t - menu window accessing' }
ToContextMenu >> subMenuWindow [ 

	^ self
]
