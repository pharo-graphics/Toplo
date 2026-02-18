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

	super applyConfiguration.
	self installEventDelegatorOnItem.
	" The item is used to setup it annulus sector constraints. 
	The item constraints measurer have to be transfered to the node container 
	because the layout uses the node container constraints.
	Notice trhat the measurer can be nil  "
	self holder nodeContainer constraints annulus sectorMeasurer:
		self item constraints annulus sectorMeasurer.
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
