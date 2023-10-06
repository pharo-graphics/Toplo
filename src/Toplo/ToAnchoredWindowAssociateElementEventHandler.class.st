Class {
	#name : #ToAnchoredWindowAssociateElementEventHandler,
	#superclass : #ToSkinnableEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindowAssociateElementEventHandler >> associateWindow [

	^ target associateWindow
]

{ #category : #'event handling' }
ToAnchoredWindowAssociateElementEventHandler >> elementPositionInSpaceChangedEvent: anEvent [

	self associateWindow applyPositionHookFromEvent: anEvent
]

{ #category : #'element handlers' }
ToAnchoredWindowAssociateElementEventHandler >> elementRemovedFromParentEvent: anEvent [

	self associateWindow close
]

{ #category : #'element handlers' }
ToAnchoredWindowAssociateElementEventHandler >> elementRemovedFromSceneGraphEvent: anEvent [

	self associateWindow close
]

{ #category : #'api - accessing' }
ToAnchoredWindowAssociateElementEventHandler >> eventsToHandle [ 

	^ super eventsToHandle, { BlElementRemovedFromParentEvent. BlElementRemovedFromSceneGraphEvent. BlElementPositionInSpaceChangedEvent }
]
