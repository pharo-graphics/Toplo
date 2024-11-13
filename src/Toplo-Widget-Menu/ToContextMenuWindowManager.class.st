Class {
	#name : #ToContextMenuWindowManager,
	#superclass : #ToPopupWindowManager,
	#category : #'Toplo-Widget-Menu-Context menu'
}

{ #category : #initialization }
ToContextMenuWindowManager >> defaultPositionHook [

	^ [ :window :theElement :event | window position: event position ]
]

{ #category : #'event handling' }
ToContextMenuWindowManager >> elementPositionInSpaceChangedEvent: anEvent [

	self currentWindowDo: [ :cw | cw close ] 
]

{ #category : #initialization }
ToContextMenuWindowManager >> initialize [

	super initialize.
	self useSecondaryMouseButton
]

{ #category : #'window handling' }
ToContextMenuWindowManager >> newWindowOpenRequestEventFromSourceEvent: anEvent [
	" request from the ToElementContextMenuEventHandler>>mouseDownEvent: "

	^ (super newWindowOpenRequestEventFromSourceEvent: anEvent)
		  sourceEvent: anEvent;
		  yourself
]

{ #category : #accessing }
ToContextMenuWindowManager >> windowClass [

	^ ToContextMenu 
]

{ #category : #accessing }
ToContextMenuWindowManager >> windowOpenRequestClass [

	^ ToContextMenuRequest 
]
