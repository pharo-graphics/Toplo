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
	
	self installEventDelegatorOnItem.

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
	" The item is used to setup it annulus sector constraints. 
	The item constraints measurer have to be transfered to the node container 
	because the layout uses the node container constraints.
	Notice trhat the measurer can be nil  "

	nodeContainerConstraints sectorMeasurer:
		itemConstraints sectorMeasurer.
	nodeContainerConstraints sectorCentroidOffset:
		itemConstraints sectorCentroidOffset.
	self fitContent
]

{ #category : #configuration }
ToCircularMenuNode >> installEventDelegatorOnItem [

	| nodeContainer |
	nodeContainer := self holder nodeContainer.
	eventDelegator ifNotNil: [
		nodeContainer removeEventHandler: eventDelegator.
		eventDelegator := nil ].
	item ifNil: [ ^ self ].
	eventDelegator := BlEventDelegator delegate: BlUIEvent to: item.
	nodeContainer addEventHandler: eventDelegator.
	nodeContainer
		addEventFilterOn: BlUIEvent
		do: [ :evt | evt source: self holder nodeContainer ].
	item installedSkinStateGenerator authorizedSource:
		self holder nodeContainer
]
