Class {
	#name : #ToListPrimarySelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#instVars : [
		'differedUpdateTask'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> differUpdateSelectionFrom: anElement [

	differedUpdateTask ifNotNil: [ ^ self ].
	differedUpdateTask := BlTaskAction new action: [
		                      anElement updateAllSelections.
		                      differedUpdateTask := nil ].
	anElement enqueueTask: differedUpdateTask
]

{ #category : #'api - accessing' }
ToListPrimarySelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToListPrimarySelectionChangedEvent }
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]
