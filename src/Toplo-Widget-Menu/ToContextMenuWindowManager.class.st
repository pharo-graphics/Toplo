Class {
	#name : #ToContextMenuWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : 'Toplo-Widget-Menu-Context menu'
}

{ #category : #initialization }
ToContextMenuWindowManager >> defaultPositionHook [

	^ [ :window :theElement :event | window position: event position ]
]

{ #category : #accessing }
ToContextMenuWindowManager >> elementEventHandlerClass [ 

	^ ToElementWithContextMenuEventHandler
]

{ #category : #initialization }
ToContextMenuWindowManager >> initialize [

	super initialize.
	self useSecondaryMouseButton
]

{ #category : #accessing }
ToContextMenuWindowManager >> windowClass [

	^ ToContextMenu 
]

{ #category : #accessing }
ToContextMenuWindowManager >> windowRequestClass [

	^ ToContextMenuRequest 
]
