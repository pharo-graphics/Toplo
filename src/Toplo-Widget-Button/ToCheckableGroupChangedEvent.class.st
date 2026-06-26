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
ToCheckableGroupChangedEvent >> checkedList [

	^ checkedList
]

{ #category : #accessing }
ToCheckableGroupChangedEvent >> checkedList: aCollection [

	checkedList := aCollection
]

{ #category : #sending }
ToCheckableGroupChangedEvent >> sendTo: anObject [

	anObject checkableGroupChangedEvent: self
]

{ #category : #accessing }
ToCheckableGroupChangedEvent >> uncheckedList [

	^ uncheckedList
]

{ #category : #accessing }
ToCheckableGroupChangedEvent >> uncheckedList: aCollection [

	uncheckedList := aCollection
]
