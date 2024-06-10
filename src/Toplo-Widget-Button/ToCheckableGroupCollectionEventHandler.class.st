Class {
	#name : #ToCheckableGroupCollectionEventHandler,
	#superclass : #ToObservableCollectionEventHandler,
	#instVars : [
		'checkableGroup'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #accessing }
ToCheckableGroupCollectionEventHandler >> checkableGroup: aCheckableGroup [

	checkableGroup := aCheckableGroup 
]

{ #category : #'data events handling' }
ToCheckableGroupCollectionEventHandler >> collectionAddEvent: anEvent [

	checkableGroup checkingStrategy onAddEvent: anEvent in: checkableGroup
]

{ #category : #'data events handling' }
ToCheckableGroupCollectionEventHandler >> collectionRemoveEvent: anEvent [

	checkableGroup checkingStrategy onRemoveEvent: anEvent in: checkableGroup
]

{ #category : #'data events handling' }
ToCheckableGroupCollectionEventHandler >> collectionUpdateRequest: aRequest [

	self error: 'Changing a button in a CheckableGroup is not allowed'
]
