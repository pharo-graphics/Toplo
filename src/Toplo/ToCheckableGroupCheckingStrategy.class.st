"
aStrategy can be Strong, WithUncheck or None
	- Strict means that there must be always one and only one checked element. 
	- WithUncheck  means that only one checked element is alowed. A checked element can be unchecked. As a consequence,  a group may have no checked element.
	- None means that there is no rule : an element can checked or unchecked whatever the others element state

"
Class {
	#name : #ToCheckableGroupCheckingStrategy,
	#superclass : #Object,
	#category : #'Toplo-Widget-Button'
}

{ #category : #notifications }
ToCheckableGroupCheckingStrategy >> armCheckable: aCheckable in: aGroup [

	aCheckable whenCheckedDo: [ aCheckable check ].
	aCheckable whenUncheckedDo: [ aCheckable uncheck ].

]

{ #category : #notifications }
ToCheckableGroupCheckingStrategy >> buttonInserted: aCheckable in: aGroup [

	aCheckable group: aGroup.
	self armCheckable: aCheckable in: aGroup.
	
	" In case of a dresser change, the checkable must be re-armed
	to launch the state actions 
	related to https://github.com/plantec/Toplo/issues/28 "
	aCheckable
		whenAnnouncement: ToStatesSetupAnnouncement
		do: [ self armCheckable: aCheckable in: aGroup ]
]

{ #category : #notifications }
ToCheckableGroupCheckingStrategy >> buttonRemoved: aCheckable in: aGroup [

	aCheckable group: nil
]

{ #category : #testing }
ToCheckableGroupCheckingStrategy >> canSwitchToNextState: aCheckable [

	^ true
]

{ #category : #testing }
ToCheckableGroupCheckingStrategy >> checked: aCheckable in: aGroup [

	aCheckable privateCheck.
	aGroup
		uncheckAllExcept: aCheckable
		ifFoundDo: [  ].
	aGroup notifyChanged
]

{ #category : #notifications }
ToCheckableGroupCheckingStrategy >> notifyBeforeButtonsInserted: aCollectionChangeAnnouncement in: aGroup [


]

{ #category : #notifications }
ToCheckableGroupCheckingStrategy >> notifyBeforeButtonsRemoved: aCollectionChangeAnnouncement in: aGroup [


]

{ #category : #notifications }
ToCheckableGroupCheckingStrategy >> notifyButtonsInserted: aCollectionChangeAnnouncement in: aGroup [

	aCollectionChangeAnnouncement interval do: [ :idx | | aCheckable |
		aCheckable := aGroup buttons at: idx.
		self buttonInserted: aCheckable in: aGroup]
]

{ #category : #notifications }
ToCheckableGroupCheckingStrategy >> notifyButtonsRemoved: aCollectionChangeAnnouncement in: aGroup [

	aCollectionChangeAnnouncement removed do: [ :checkable |
		self buttonRemoved: checkable in: aGroup ]
]

{ #category : #testing }
ToCheckableGroupCheckingStrategy >> unchecked: aCheckable in: aGroup [


]
