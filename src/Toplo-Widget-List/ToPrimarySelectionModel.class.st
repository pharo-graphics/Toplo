Class {
	#name : #ToPrimarySelectionModel,
	#superclass : #ToFrontSelectionModel,
	#instVars : [
		'subSelectionModelIndex',
		'makeDisabledUnselectable'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #copying }
ToPrimarySelectionModel >> copySelectionFrom: anotherSelectionModel [

	subSelectionModelIndex copySelectionFrom: anotherSelectionModel subSelectionModelIndex.
	super copySelectionFrom: anotherSelectionModel.

]

{ #category : #initialization }
ToPrimarySelectionModel >> initialize [

	super initialize.
	subSelectionModelIndex := ToDictionaryBasedSubSelectionModelRegistry new.
	makeDisabledUnselectable := false
]

{ #category : #testing }
ToPrimarySelectionModel >> isUnselectableIndex: anIndex [

	makeDisabledUnselectable ifTrue: [
		self disabledSelectionModelDo: [ :sm |
			(sm containsIndex: anIndex) ifTrue: [ ^ true ] ] ].
	^ super isUnselectableIndex: anIndex
]

{ #category : #accessing }
ToPrimarySelectionModel >> makeDisabledUnselectable: aBoolean [

	makeDisabledUnselectable := aBoolean
]

{ #category : #'instance creation' }
ToPrimarySelectionModel >> newSecondarySelectionModel [

	^ ToSecondarySelectionModel new
		  primarySelectionModel: self;
		  yourself
]

{ #category : #copying }
ToPrimarySelectionModel >> postCopy [ 

	super postCopy.
	subSelectionModelIndex := subSelectionModelIndex copy
]

{ #category : #accessing }
ToPrimarySelectionModel >> subSelectionModelIndex [

	^ subSelectionModelIndex 
]

{ #category : #accessing }
ToPrimarySelectionModel >> subSelectionModelIndex: anIdentityDictionary [

	subSelectionModelIndex := anIdentityDictionary
]

{ #category : #enumerating }
ToPrimarySelectionModel >> withAllSubModelsDo: aValuable [

	aValuable value: self.
	subSelectionModelIndex withAllSubModelsDo: aValuable
	
]
