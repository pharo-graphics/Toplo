Class {
	#name : #ToCheckableGroupButtonCollectionEventHandler,
	#superclass : #ToObservableCollectionEventHandler,
	#instVars : [
		'checkableGroup'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #accessing }
ToCheckableGroupButtonCollectionEventHandler >> checkableGroup: aCheckableGroup [

	checkableGroup := aCheckableGroup 
]

{ #category : #'data events handling' }
ToCheckableGroupButtonCollectionEventHandler >> collectionAddEvent: anEvent [

	checkableGroup checkingStrategy onButtonsAddEvent: anEvent in: checkableGroup
]

{ #category : #'data events handling' }
ToCheckableGroupButtonCollectionEventHandler >> collectionRemoveEvent: anEvent [

	checkableGroup checkingStrategy onButtonsRemoveEvent: anEvent in: checkableGroup
]

{ #category : #'data events handling' }
ToCheckableGroupButtonCollectionEventHandler >> collectionUpdateRequest: aRequest [

	self error: 'Changing a button in a CheckableGroup is not allowed'
]
