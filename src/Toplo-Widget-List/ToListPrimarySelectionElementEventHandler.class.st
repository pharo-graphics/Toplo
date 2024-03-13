Class {
	#name : #ToListPrimarySelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'postponedUpdateTask'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> blurEvent: anEvent [

	" Don't update the selection when the element is removed from the scene 
	This is the case if the event reason is for element removal "
	anEvent isDueToRemoval ifTrue: [ ^ self ].
	self enqueueUpdateSelectionFromEvent: anEvent
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> criticalUpdateSelectionFromEvent: anEvent [

	anEvent currentTarget layoutCritical: [
		self updateSelectionFromEvent: anEvent ]
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> elementExtentChangedEvent: anEvent [

	self enqueueUpdateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> elementScrolledEvent: anEvent [

	self criticalUpdateSelectionFromEvent: anEvent
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> enqueueUpdateSelectionFromEvent: anEvent [

	anEvent currentTarget enqueueTask:
		(BlTaskAction new action: [ self updateSelectionFromEvent: anEvent ])
]

{ #category : #'api - accessing' }
ToListPrimarySelectionElementEventHandler >> eventsToHandle [

	^ {
		  BlElementExtentChangedEvent.
		  BlElementScrolledEvent.
		  BlFocusEvent.
		  BlBlurEvent.
		  ToListPrimarySelectionDirtyEvent.
		  ToListPrimarySelectionChangedEvent }
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> focusEvent: anEvent [

	self criticalUpdateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> listPrimarySelectionChangedEvent: anEvent [

	self criticalUpdateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> listPrimarySelectionDirtyEvent: anEvent [

	self criticalUpdateSelectionFromEvent: anEvent
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> newSelectionElementsFromEvent: anEvent [
	" return a collection with instances of ToListPrimarySelectionElement "

	| adjacentNodeGroups target |
	target := anEvent currentTarget.

	adjacentNodeGroups := target infinite nodeGroupsSatisfying: [ :n |
		                      n holder isSelected and: [
			                      n holder isHidden not ] ].
	^ adjacentNodeGroups collect: [ :g |
		  ToListPrimarySelectionElement new
			  listElement: target;
			  nodes: g;
			  yourself ]
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> postponeSelectionElementUpdateIn: anElement [

	postponedUpdateTask ifNotNil: [ ^ self ].
	postponedUpdateTask := BlTaskAction new action: [
		                      anElement dispatchEvent:
			                      ToListPrimarySelectionDirtyEvent new.
		                      postponedUpdateTask := nil ].
	anElement enqueueTask: postponedUpdateTask
]

{ #category : #'selection managing' }
ToListPrimarySelectionElementEventHandler >> updateSelectionFromEvent: anEvent [

	| newSelElements target infinite previous nodesArray selectionModel |
	target := anEvent currentTarget.
	infinite := target infinite.

	target isAttachedToSceneGraph ifFalse: [
		self postponeSelectionElementUpdateIn: target.
		^ self ].
	previous := target primarySelectionElements.
	nodesArray := target infinite children asArray.
	selectionModel := target selectionModel copy.
	newSelElements := self newSelectionElementsFromEvent: anEvent.
	previous do: [ :s | s removeFromParent ].
	target addChildren: newSelElements.

	" Dispatch the event that is used by the skin state generator to generate the selection state "
	nodesArray do: [ :node |
		node dispatchEvent: (ToListNodeSelectedEvent new
				 listElement: target;
				 selected: (selectionModel containsIndex: node holder position)) ]
]
