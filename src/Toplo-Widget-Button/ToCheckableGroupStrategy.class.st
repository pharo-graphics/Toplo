"
aStrategy can be Strong, WithUncheck or None
	- Strict means that there must be always one and only one checked element. 
	- WithUncheck  means that only one checked element is alowed. A checked element can be unchecked. As a consequence,  a group may have no checked element.
	- None means that there is no rule : an element can checked or unchecked whatever the others element state

"
Class {
	#name : #ToCheckableGroupStrategy,
	#superclass : #Object,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #testing }
ToCheckableGroupStrategy >> allowChangeWith: aCheckValue in: aGroup forCheckable: aCheckable [

	self subclassResponsibility
]

{ #category : #testing }
ToCheckableGroupStrategy >> allowUnchecking [

	^ true
]

{ #category : #testing }
ToCheckableGroupStrategy >> isNoneStrategy [

	^ false
]

{ #category : #notifications }
ToCheckableGroupStrategy >> onAddEvent: aCollectionChangeEvent in: aGroup [

	aCollectionChangeEvent interval do: [ :idx |
		| aCheckable |
		aCheckable := aGroup registeredCheckables at: idx.
		self register: aCheckable in: aGroup ]
]

{ #category : #notifications }
ToCheckableGroupStrategy >> onRemoveEvent: aCollectionChangeEvent in: aGroup [

	aCollectionChangeEvent removed do: [ :checkable |
		self unregister: checkable from: aGroup ]
]

{ #category : #notifications }
ToCheckableGroupStrategy >> register: aCheckable in: aGroup [

	aCheckable group: aGroup
]

{ #category : #notifications }
ToCheckableGroupStrategy >> unregister: aCheckable from: aGroup [

	aCheckable group: nil
]
