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
ToCheckableGroupStrategy >> onButtonAdded: aCheckable in: aGroup [

	self
		deprecated: 'send #register:in: instead'
		transformWith: '`@receiver onButtonAdded: `@arg1 in: `@arg2'
			-> '`@receiver register: `@arg1 in: `@arg2'.

	self register: aCheckable in: aGroup
]

{ #category : #notifications }
ToCheckableGroupStrategy >> onButtonRemoved: aCheckable in: aGroup [

	self
		deprecated: 'send #unregister:in: instead'
		transformWith: '`@receiver onButtonRemoved: `@arg1 in: `@arg2'
			-> '`@receiver unregister: `@arg1 from: `@arg2'.

	self unregister: aCheckable from: aGroup
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
