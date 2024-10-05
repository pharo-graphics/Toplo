Class {
	#name : #ToPrimarySelectionModel,
	#superclass : #ToFrontSelectionModel,
	#instVars : [
		'subSelectionModelIndex'
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
	subSelectionModelIndex := ToDictionaryBasedSubSelectionModelRegistry new
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
