"
aStrategy can be Strong, WithUncheck or None
	- Strict means that there must be always one and only one checked element. 
	- WithUncheck  means that only one checked element is alowed. A checked element can be unchecked. As a consequence,  a group may have no checked element.
	- None means that there is no rule : an element can checked or unchecked whatever the others element state

"
Class {
	#name : #ToCheckableGroupCheckingStrategy,
	#superclass : #Object,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #testing }
ToCheckableGroupCheckingStrategy >> allowUnchecking [

	^ true
]

{ #category : #testing }
ToCheckableGroupCheckingStrategy >> checkRequestEvent: aCheckRequest in: aGroup [

	self subclassResponsibility 
]

{ #category : #notifications }
ToCheckableGroupCheckingStrategy >> onButtonAdded: aCheckable in: aGroup [

	aCheckable group: aGroup
]

{ #category : #notifications }
ToCheckableGroupCheckingStrategy >> onButtonRemoved: aCheckable in: aGroup [

	aCheckable group: nil
]

{ #category : #notifications }
ToCheckableGroupCheckingStrategy >> onButtonsAddEvent: aCollectionChangeEvent in: aGroup [

	aCollectionChangeEvent interval do: [ :idx | | aCheckable |
		aCheckable := aGroup buttons at: idx.
		self onButtonAdded: aCheckable in: aGroup]
]

{ #category : #notifications }
ToCheckableGroupCheckingStrategy >> onButtonsRemoveEvent: aCollectionChangeEvent in: aGroup [

	aCollectionChangeEvent removed do: [ :checkable |
		self onButtonRemoved: checkable in: aGroup ]
]
