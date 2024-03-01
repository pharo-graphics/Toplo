Class {
	#name : #ToListPrimarySelectionElementEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> blurEvent: anEvent [

	" Don't update the selection when the element is removed from the scene 
	This is the case if the event reason is for element removal "
	anEvent isDueToRemoval ifTrue: [ ^ self ].
	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> elementExtentChangedEvent: anEvent [

	self updateSelectionFromEvent: anEvent
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> elementScrolledEvent: anEvent [

	self updateSelectionFromEvent: anEvent
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
ToListPrimarySelectionElementEventHandler >> newSelectionElementsFromEvent: anEvent [
	" return a collection with instances of ToListPrimarySelectionElement "

	| adjacentNodeGroups target |
	target := anEvent currentTarget.
	adjacentNodeGroups := target infinite nodeGroupsSatisfying: [ :n |
		                      n holder isSelectable and: [
			                      n holder isSelected ] ].
	^ adjacentNodeGroups collect: [ :g |
		  ToListPrimarySelectionElement new
			  listElement: target;
			  nodes: g;
			  yourself ]
]

{ #category : #'element handlers' }
ToListPrimarySelectionElementEventHandler >> updateSelectionFromEvent: anEvent [

	| newSelElements target previous nodesArray selectionModel |
	target := anEvent currentTarget.
	target isAttachedToSceneGraph ifFalse: [ ^ self ].
	previous := target primarySelectionElements.
	newSelElements := self newSelectionElementsFromEvent: anEvent.
	previous do: [ :s | s removeFromParent ].
	target addChildren: newSelElements.

	nodesArray := target infinite children asArray.
	selectionModel := target selectionModel.

	" Dispatch the event that is used by the skin state generator to generate the selection state "
	nodesArray do: [ :node |
		node holder isSelectable ifTrue: [
			node dispatchEvent: (ToListNodeSelectedEvent new
					 listElement: target;
					 selected: (selectionModel containsIndex: node holder position)) ] ]
]
