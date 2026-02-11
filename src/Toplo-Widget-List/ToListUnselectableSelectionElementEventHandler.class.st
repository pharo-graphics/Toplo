Class {
	#name : #ToListUnselectableSelectionElementEventHandler,
	#superclass : #ToListSelectionElementEventHandler,
	#instVars : [
		'prevSkinEventClasses'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'api - accessing' }
ToListUnselectableSelectionElementEventHandler >> eventsToHandle [

	^ super eventsToHandle , {
		  ToListCheckableNodeUseChanged.
		  ToListUnselectableSelectionChangedEvent }
]

{ #category : #'selection managing' }
ToListUnselectableSelectionElementEventHandler >> listCheckableNodeUseChanged: anEvent [
	" if use checkbox is true, thenmake the list node containers receive/manage the unselectable specific events.
	if use checkbox is false, then come back to the previous state "

	| listElement mode |
	listElement := anEvent currentTarget.
	mode := listElement unselectableSelectionMode.
	listElement useCheckbox
		ifTrue: [
				prevSkinEventClasses := {
					                        mode selectionSkinEventClass.
					                        mode deselectionSkinEventClass }.
				mode withDefaultSelectionSkinEvents ]
		ifFalse: [
				mode selectionSkinEventClass: prevSkinEventClasses first.
				mode deselectionSkinEventClass: prevSkinEventClasses second ]
]

{ #category : #'element handlers' }
ToListUnselectableSelectionElementEventHandler >> listUnselectableSelectionChangedEvent: anEvent [

	| listElement |
	listElement := anEvent currentTarget.
	self updateSelectionFromEvent: anEvent.
	listElement unselectableSelectionModel selectedIndexesIntervalsDo: [ :int |
		listElement selecter deselectInterval: int ]
]
