"
aStrategy can be Strong, WithUncheck or None
	- Strict means that there must be always one and only one checked element. 
	- WithUncheck  means that only one checked element is alowed. A checked element can be unchecked. As a consequence,  a group may have no checked element.
	- None means that there is no rule : an element can checked or unchecked whatever the others element state

"
Class {
	#name : 'ToCheckableGroupCheckingStrategy',
	#superclass : 'Object',
	#category : 'Toplo-Widget-Button-Checkable',
	#package : 'Toplo-Widget-Button',
	#tag : 'Checkable'
}

{ #category : 'notifications' }
ToCheckableGroupCheckingStrategy >> buttonInserted: aCheckable in: aGroup [

	aCheckable group: aGroup
]

{ #category : 'notifications' }
ToCheckableGroupCheckingStrategy >> buttonRemoved: aCheckable in: aGroup [

	aCheckable group: nil
]

{ #category : 'testing' }
ToCheckableGroupCheckingStrategy >> checkRequestEvent: aCheckRequest in: aGroup [

	self subclassResponsibility 
]

{ #category : 'notifications' }
ToCheckableGroupCheckingStrategy >> notifyBeforeButtonsInserted: aCollectionChangeAnnouncement in: aGroup [


]

{ #category : 'notifications' }
ToCheckableGroupCheckingStrategy >> notifyBeforeButtonsRemoved: aCollectionChangeAnnouncement in: aGroup [


]

{ #category : 'notifications' }
ToCheckableGroupCheckingStrategy >> notifyButtonsInserted: aCollectionChangeAnnouncement in: aGroup [

	aCollectionChangeAnnouncement interval do: [ :idx | | aCheckable |
		aCheckable := aGroup buttons at: idx.
		self buttonInserted: aCheckable in: aGroup]
]

{ #category : 'notifications' }
ToCheckableGroupCheckingStrategy >> notifyButtonsRemoved: aCollectionChangeAnnouncement in: aGroup [

	aCollectionChangeAnnouncement removed do: [ :checkable |
		self buttonRemoved: checkable in: aGroup ]
]
