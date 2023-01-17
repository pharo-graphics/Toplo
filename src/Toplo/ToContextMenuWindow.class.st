Class {
	#name : #ToContextMenuWindow,
	#superclass : #ToMenuWindow,
	#instVars : [
		'widgetWithContextMenuEventHandler'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #initialization }
ToContextMenuWindow >> initialize [

	self class initializeSlots: self.
	super initialize.
		
	self elevation: (BlRelativeElevation elevation: SmallInteger maxVal).
	self whenWidgetChangedDo: [ :newWidget :oldWidget | 
		self uninstalledFrom: oldWidget.
		self installedIn: newWidget ]
]

{ #category : #initialization }
ToContextMenuWindow >> installedIn: aWidget [

	aWidget ifNil: [ ^ self ].
	widgetWithContextMenuEventHandler := ToWidgetWithContextMenuEventHandler new.
	aWidget addEventHandler: widgetWithContextMenuEventHandler 
]

{ #category : #initialization }
ToContextMenuWindow >> uninstalledFrom: aWidget [

	aWidget ifNil: [ ^ self ].
	aWidget removeEventFilter: widgetWithContextMenuEventHandler.
	widgetWithContextMenuEventHandler := nil
]
