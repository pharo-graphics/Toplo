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
	self whenWidgetChangedDo: [ :newWidget :oldWidget | 
		self uninstalledFrom: oldWidget.
		self installedIn: newWidget ]
]

{ #category : #initialization }
ToContextMenu >> installedIn: aWidget [

	aWidget ifNil: [ ^ self ].
	widgetWithContextMenuEventHandler := ToWidgetWithContextMenuEventHandler new.
	aWidget addEventHandler: widgetWithContextMenuEventHandler 
]

{ #category : #initialization }
ToContextMenu >> openPositionFromEvent: anEvent [

	^ anEvent position
]

{ #category : #'t - menu window accessing' }
ToContextMenu >> subMenuWindow [ 

	^ self
]

{ #category : #initialization }
ToContextMenu >> uninstalledFrom: aWidget [

	aWidget ifNil: [ ^ self ].
	aWidget removeEventFilter: widgetWithContextMenuEventHandler.
	widgetWithContextMenuEventHandler := nil
]
