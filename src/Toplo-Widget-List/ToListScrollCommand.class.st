Class {
	#name : #ToListScrollCommand,
	#superclass : #ToListElementCommand,
	#instVars : [
		'index'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToListScrollCommand >> applyOn: anObject for: aTarget [

	aTarget scrollToIndex: self index
]

{ #category : #accessing }
ToListScrollCommand >> index [

	^ index
]

{ #category : #accessing }
ToListScrollCommand >> index: anIndex [

	index := anIndex
]

{ #category : #initialization }
ToListScrollCommand >> initialize [ 

	super initialize.
	self silent: true
]
