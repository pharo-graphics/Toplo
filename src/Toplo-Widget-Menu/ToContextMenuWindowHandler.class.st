Class {
	#name : 'ToContextMenuWindowHandler',
	#superclass : 'ToMenuWindowHandler',
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'initialization' }
ToContextMenuWindowHandler >> defaulPositionHook [

	^ [ :event :theContextMenu | event position ]
]

{ #category : 'accessing' }
ToContextMenuWindowHandler >> elementEventHandlerClass [ 

	^ ToContextMenuEventHandler
]

{ #category : 'initialization' }
ToContextMenuWindowHandler >> initialize [

	super initialize.
	self useSecondaryMouseButton
]

{ #category : 'accessing' }
ToContextMenuWindowHandler >> windowBeforeBuildingEventClass [

	^ ToContextMenuBeforeBuildingEvent 
]

{ #category : 'accessing' }
ToContextMenuWindowHandler >> windowClass [

	^ ToContextMenu
]
