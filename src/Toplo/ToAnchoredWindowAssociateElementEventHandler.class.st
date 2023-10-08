Class {
	#name : #ToAnchoredWindowAssociateElementEventHandler,
	#superclass : #ToSkinnableEventHandler,
	#instVars : [
		'associateWindow'
	],
	#category : #'Toplo-Core-Window'
}

{ #category : #accessing }
ToAnchoredWindowAssociateElementEventHandler >> associateWindow [

	^ associateWindow
]

{ #category : #accessing }
ToAnchoredWindowAssociateElementEventHandler >> associateWindow: aWindowElement [

	associateWindow := aWindowElement
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
