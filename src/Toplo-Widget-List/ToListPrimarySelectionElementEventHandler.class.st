Class {
	#name : #ToListPrimarySelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#instVars : [
		'differedUpdateTask'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> blurEvent: anEvent [

	" Don't update the selection when the element is removed from the scene 
	This is the case if the event reason is for element removal "
	anEvent isDueToRemoval ifTrue: [ ^ self ].
	self updateSelectionFromEvent: anEvent
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> differUpdateSelectionFrom: anElement [

	differedUpdateTask ifNotNil: [ ^ self ].
	differedUpdateTask := BlTaskAction new action: [
		                      anElement notifyPrimarySelectionDirty.
		                      differedUpdateTask := nil ].
	anElement enqueueTask: differedUpdateTask
]

{ #category : #'api - accessing' }
ToListPrimarySelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle, {
		  BlFocusEvent.
		  BlBlurEvent.
		  ToListPrimarySelectionDirtyEvent.
		  ToListPrimarySelectionChangedEvent }
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> focusEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> listPrimarySelectionDirtyEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> selectionModeIn: aTarget [

	^ aTarget selectionMode
]
