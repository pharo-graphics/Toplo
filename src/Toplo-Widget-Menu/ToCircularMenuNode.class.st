Class {
	#name : #ToCircularMenuNode,
	#superclass : #ToMenuItemNode,
	#instVars : [
		'eventDelegator'
	],
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #configuration }
ToCircularMenuNode >> applyConfiguration [

	| nodeContainerConstraints itemConstraints |
	super applyConfiguration.

	nodeContainerConstraints := self holder nodeContainer constraints
		                            annulus.
	itemConstraints := self item constraints annulus.

	self constraintsDo: [ :c |
			c ignoreByLayout.
			c anchors removeAll.
			c anchors add:
				(c anchors centerAnchor on:
					 (c anchors parent centroidAnchor offset:
						  itemConstraints sectorCentroidOffset)) ].
	" When added in a menu, the item constraints annulus can be used to setup 
	its annulus sector constraints. 
	The item constraints measurer have to be transfered to the node container 
	because the layout uses the node container constraints.
	Notice that the measurer can be nil  "

	nodeContainerConstraints sectorMeasurer:
		itemConstraints sectorMeasurer.
	nodeContainerConstraints sectorCentroidOffset:
		itemConstraints sectorCentroidOffset.
	self fitContent
]

{ #category : #'t - item node' }
ToCircularMenuNode >> installEventDelegatorOnItem [

	| nodeContainer uiEventsToDelegate |
	nodeContainer := self holder nodeContainer.
	eventDelegator ifNotNil: [
			nodeContainer removeEventHandler: eventDelegator.
			eventDelegator := nil ].
	item ifNil: [ ^ self ].
	uiEventsToDelegate := IdentitySet new.
	uiEventsToDelegate addAll: ToSkinStateGenerator handledUIEvents.
	" remove the BlClickEvent. Not sure to understand why. 
	Maybe because it is not handled as other mouse events bythe mouse processor.
	If not r emoved here, then the click event is dispatched twice "
	uiEventsToDelegate remove: BlClickEvent.
	eventDelegator := ToUIEventDelegator
		                  delegate: uiEventsToDelegate asArray
		                  to: item.
	nodeContainer addEventHandler: eventDelegator
]

{ #category : #'t - item node' }
ToCircularMenuNode >> item: anElement [

	super item: anElement.
	self installEventDelegatorOnItem
]
