Class {
	#name : #ToCheckableGroupChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'checkedList',
		'uncheckedList'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #accessing }
ToCheckableGroupChangedEvent >> checkedButtons [

	self
		deprecated: 'send #checkedList instead'
		transformWith:
		'`@receiver checkedButtons' -> '`@receiver checkedList'.

	^ self checkedList
]

{ #category : #accessing }
ToCheckableGroupChangedEvent >> checkedButtons: anObject [

	self
		deprecated: 'send #checkedlist: instead'
		transformWith:
		'`@receiver checkedButtons: `@arg'
		-> '`@receiver checkedList: `@arg'.

	self checkedList: anObject
]

{ #category : #accessing }
ToCheckableGroupChangedEvent >> checkedList [

	^ checkedList
]

{ #category : #accessing }
ToCheckableGroupChangedEvent >> checkedList: aCollection [

	checkedList := aCollection
]

{ #category : #accessing }
ToCheckableGroupChangedEvent >> uncheckedButtons [

	self
		deprecated: 'send #uncheckedList instead'
		transformWith:
		'`@receiver checkedButtons' -> '`@receiver uncheckedList'.

	^ self uncheckedList
]

{ #category : #accessing }
ToCheckableGroupChangedEvent >> uncheckedButtons: anObject [

	self
		deprecated: 'send #uncheckedlist: instead'
		transformWith: '`@receiver checkedButtons: `@arg'
			-> '`@receiver uncheckedList: `@arg'.

	self uncheckedList: anObject
]

{ #category : #accessing }
ToCheckableGroupChangedEvent >> uncheckedList [

	^ uncheckedList
]

{ #category : #accessing }
ToCheckableGroupChangedEvent >> uncheckedList: aCollection [

	uncheckedList := aCollection
]
