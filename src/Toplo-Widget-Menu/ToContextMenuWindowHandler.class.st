Class {
	#name : #ToContextMenuWindowHandler,
	#superclass : #ToMenuWindowHandler,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToContextMenuWindowHandler >> defaulPositionHook [

	^ [ :event | event position ]
]

{ #category : #accessing }
ToContextMenuWindowHandler >> elementEventHandlerClass [ 

	^ ToContextMenuEventHandler
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
