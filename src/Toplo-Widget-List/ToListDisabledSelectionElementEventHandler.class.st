Class {
	#name : #ToListDisabledSelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#instVars : [
		'touchedIntervals',
		'differedUpdateTask'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'api - accessing' }
ToListDisabledSelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , { ToListDisabledSelectionChangedEvent }
]

{ #category : #initialization }
ToListDisabledSelectionElementEventHandler >> initialize [ 

	super initialize.
	touchedIntervals := ToIntervalCollection new
]

{ #category : #'element handlers' }
ToListDisabledSelectionElementEventHandler >> listDisabledSelectionChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	self updateSelectionFromEvent: anEvent.

	touchedIntervals addAllIntervals: anEvent touchedIntervals.
	
	differedUpdateTask ifNotNil: [ ^ self ].
	differedUpdateTask := BlTaskAction new action: [
			                      self updateSelectionFromEvent: anEvent.
			                      touchedIntervals do: [ :int |
				                      target dataSource notifyItemsChanged: int ].
			                      touchedIntervals removeAll.
			                      differedUpdateTask := nil ].
	target enqueueTask: differedUpdateTask
]
