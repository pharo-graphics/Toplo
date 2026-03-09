Class {
	#name : #ToListDataSourceCommand,
	#superclass : #Object,
	#instVars : [
		'positionStart',
		'itemCount'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #application }
ToListDataSourceCommand >> applyIn: aFiniteListElement [

	self subclassResponsibility 
]

{ #category : #commands }
ToListDataSourceCommand >> dispatchToLayout: aLayout [
]

{ #category : #accessing }
ToListDataSourceCommand >> itemCount [

	^ itemCount
]

{ #category : #accessing }
ToListDataSourceCommand >> itemCount: anObject [

	itemCount := anObject
]

{ #category : #accessing }
ToListDataSourceCommand >> positionStart [

	^ positionStart
]

{ #category : #accessing }
ToListDataSourceCommand >> positionStart: anObject [

	positionStart := anObject
]
