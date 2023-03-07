"
Description
--------------------

I am an abstract class defining the API of a sorting state.

I'll manage the behavior of a aTSortingStrategyWithState subclasses using me that is related to its state.	
	
I follow the State design pattern.
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	context:		<aTSortingStrategyWithState>	The context I am the state of.

"
Class {
	#name : #ToFTAbstractSortingState,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'Toplo-FastTable-Sorting'
}

{ #category : #'instance creation' }
ToFTAbstractSortingState class >> context: aContext [
	^ self new
		context: aContext;
		yourself
]

{ #category : #accessing }
ToFTAbstractSortingState >> context [
	^ context
]

{ #category : #accessing }
ToFTAbstractSortingState >> context: anObject [
	context := anObject
]

{ #category : #sorting }
ToFTAbstractSortingState >> executeSortingOn: aDataSource [
	self subclassResponsibility
]

{ #category : #accessing }
ToFTAbstractSortingState >> nextState [
	^ self subclassResponsibility
]

{ #category : #sorting }
ToFTAbstractSortingState >> sort: aDataSource [
	| nextState |
	nextState := self nextState.
	self context state: nextState.
	nextState executeSortingOn: aDataSource
]

{ #category : #accessing }
ToFTAbstractSortingState >> sortingIcon [
	^ self subclassResponsibility
]
