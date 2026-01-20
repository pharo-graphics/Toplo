Class {
	#name : #ToListPrimarySelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#instVars : [
		'differedUpdateTask',
		'wasSelectingOnClick'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> differUpdateSelectionFrom: anElement [

	differedUpdateTask ifNotNil: [ ^ self ].
	differedUpdateTask := BlTaskAction new action: [
		                      anElement requestUpdateAllSelections.
		                      differedUpdateTask := nil ].
	anElement enqueueTask: differedUpdateTask
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> elementLayoutComputedEvent: anEvent [
	" in case of a list with checkboxes, the checkboxes have 
	to be up synchronized with ne updated selection model "

	| listElement |
	listElement := anEvent currentTarget.
	listElement nodeManager checkableNode ifFalse: [ ^ self ].
	listElement checkboxesUpdateRequested ifFalse: [ ^ self ].
	listElement checkboxesUpdateDone.
	listElement nodeContainersDo: [ :nc |
			nc checkbox ifNotNil: [ :cbox |
				cbox privateChecked: nc holder isSelected ] ]
]

{ #category : #'api - accessing' }
ToListPrimarySelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  ToListCheckableNodeUseChanged.
		  ToListPrimarySelectionChangedEvent.
		  BlElementLayoutComputedEvent }
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
	listElement notifyDataSourceChanged
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	listElement useCheckbox ifTrue: [
		listElement requestUpdateCheckboxes ].
	self updateSelectionFromEvent: anEvent
]
