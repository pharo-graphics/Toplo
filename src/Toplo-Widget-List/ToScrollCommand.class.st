Class {
	#name : #ToScrollCommand,
	#superclass : #ToListElementCommand,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'private - hook' }
ToScrollCommand >> applyOn: anOperator [

	" ask the operator passed as argument to actually apply the command. "

	self
		deprecated: 'Use applyOnOperator: instead'
		transformWith: '`@receiver applyOn: `@argument'
			-> '`@receiver applyOnOperator: `@argument'.
	self applyOnOperator: anOperator
]

{ #category : #'private - hook' }
ToScrollCommand >> applyOnOperator: anOperator [ 

	anOperator scrollCommand: self.
	super applyOnOperator: anOperator
]

{ #category : #accessing }
ToScrollCommand >> index [

	^ index
]

{ #category : #accessing }
ToScrollCommand >> index: anIndex [

	index := anIndex
]
