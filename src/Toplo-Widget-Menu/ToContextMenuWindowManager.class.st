Class {
	#name : 'ToContextMenuWindowManager',
	#superclass : 'ToPopupWindowManager',
	#category : 'Toplo-Widget-Menu-Context menu',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Context menu'
}

{ #category : 'initialization' }
ToContextMenuWindowManager >> defaultPositionHook [

	^ [ :event :theContextMenu | event position ]
]

{ #category : 'accessing' }
ToContextMenuWindowManager >> elementEventHandlerClass [ 

	^ ToElementWithContextMenuEventHandler
]

{ #category : 'initialization' }
ToContextMenuWindowManager >> initialize [

	super initialize.
	self useSecondaryMouseButton
]

{ #category : 'accessing' }
ToContextMenuWindowManager >> windowClass [

	^ ToContextMenu 
]

{ #category : 'accessing' }
ToContextMenuWindowManager >> windowRequestClass [

	^ ToContextMenuRequest 
]
