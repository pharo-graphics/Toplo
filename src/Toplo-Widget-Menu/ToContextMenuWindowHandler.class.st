Class {
	#name : #ToContextMenuWindowHandler,
	#superclass : #ToPopupWindowHandler,
	#category : 'Toplo-Widget-Menu-Context Menu'
}

{ #category : #initialization }
ToContextMenuWindowHandler >> defaulPositionHook [

	^ [ :event :theContextMenu | event position ]
]

{ #category : #initialization }
ToContextMenuWindowHandler >> initialize [

	super initialize.
	self useSecondaryMouseButton
]

{ #category : #accessing }
ToContextMenuWindowHandler >> windowBeforeBuildingEventClass [

	^ ToContextMenuBeforeBuildingEvent 
]

{ #category : #accessing }
ToContextMenuWindowHandler >> windowClass [

	^ ToContextMenu
]
