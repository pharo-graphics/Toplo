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
