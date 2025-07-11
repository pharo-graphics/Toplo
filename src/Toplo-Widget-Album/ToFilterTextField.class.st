"
A text field that hold the filter to apply to a CollectionFilter when the text is edited
"
Class {
	#name : #ToFilterTextField,
	#superclass : #ToTextField,
	#instVars : [
		'filter',
		'collectionFilter'
	],
	#category : #'Toplo-Widget-Album-TextField'
}

{ #category : #accessing }
ToFilterTextField >> collectionFilter [ 

	^ collectionFilter 

	
]

{ #category : #accessing }
ToFilterTextField >> collectionFilter: anObservableCollectionFilterApplier [

	collectionFilter := anObservableCollectionFilterApplier

	
]

{ #category : #initialization }
ToFilterTextField >> initialize [

	super initialize.
	self whenTextEditedDo: [
			self collectionFilter ifNotNil: [ :cf |
					| pattern |
					pattern := self asString.
					cf pattern: pattern ] ]
]
