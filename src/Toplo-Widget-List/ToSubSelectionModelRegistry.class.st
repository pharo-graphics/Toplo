Class {
	#name : #ToSubSelectionModelRegistry,
	#superclass : #Object,
	#instVars : [
		'subs'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #initialization }
ToSubSelectionModelRegistry >> initialize [ 

	super initialize.
	subs := self newSubSelectionModelRegistry
]

{ #category : #initialization }
ToSubSelectionModelRegistry >> newSubSelectionModelRegistry [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToSubSelectionModelRegistry >> recordSubSelectionModel: aSelectionModel [

	self subclassResponsibility 
]

{ #category : #initialization }
ToSubSelectionModelRegistry >> resetAll [

	self selectionModelsDo: [ :sm | sm resetAll ]
]

{ #category : #enumerating }
ToSubSelectionModelRegistry >> selectionModelsDo: aBlock [

	self subclassResponsibility 
]

{ #category : #accessing }
ToSubSelectionModelRegistry >> subSelectionModelWithId: anUniqueId [

	self subclassResponsibility 
]
