Class {
	#name : #ToListPrimarySelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#instVars : [
		'differedUpdateTask',
		'wasSelectingOnClick'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> differUpdateSelectionFrom: anElement [

	differedUpdateTask ifNotNil: [ ^ self ].
	differedUpdateTask := BlTaskAction new action: [
		                      anElement requestUpdateAllSelections.
		                      differedUpdateTask := nil ].
	anElement enqueueTask: differedUpdateTask
]

{ #category : #'api - accessing' }
ToListPrimarySelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  ToListCheckableNodeUseChanged.
		  ToListPrimarySelectionChangedEvent }
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> listCheckableNodeUseChanged: anEvent [

	| listElement |
	listElement := anEvent currentTarget.

	listElement nodeManager checkableNode: listElement useCheckbox.
	listElement useCheckbox
		ifTrue: [
				wasSelectingOnClick := listElement selectionMode selectOnClick.
				listElement selectionMode selectOnClick: false ]
		ifFalse: [
		listElement selectionMode selectOnClick: wasSelectingOnClick ].
	listElement inUIProcessDo: [ listElement notifyDataSourceChanged ]
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]
