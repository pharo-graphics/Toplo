Class {
	#name : #ToListDataSourceCommand,
	#superclass : #Object,
	#instVars : [
		'positionStart',
		'itemCount'
	],
	#category : #'Toplo-Widget-List-InnerList'
}

{ #category : #application }
ToListDataSourceCommand >> applyIn: aFiniteListElement [

	self subclassResponsibility 
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
