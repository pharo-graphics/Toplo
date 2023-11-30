Class {
	#name : 'ToContextMenuWindowHandler',
	#superclass : 'ToPopupWindowHandler',
	#category : 'Toplo-Widget-Menu-Context Menu',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Context Menu'
}

{ #category : 'initialization' }
ToContextMenuWindowHandler >> defaulPositionHook [

	^ [ :event :theContextMenu | event position ]
]

{ #category : 'initialization' }
ToContextMenuWindowHandler >> initialize [

	super initialize.
	self useSecondaryMouseButton
]

{ #category : 'accessing' }
ToContextMenuWindowHandler >> windowClass [

	^ ToContextMenu
]

{ #category : 'accessing' }
ToContextMenuWindowHandler >> windowRequestClass [

	^ ToContextMenuRequest 
]
