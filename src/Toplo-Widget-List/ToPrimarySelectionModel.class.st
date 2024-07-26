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

	super copySelectionFrom: anotherSelectionModel.
	subSelectionModelIndex := anotherSelectionModel subSelectionModelIndex copy
]

{ #category : #initialization }
ToPrimarySelectionModel >> initialize [

	super initialize.
	subSelectionModelIndex := ToOrderedCollectionBasedSubSelectionModelRegistry new
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
