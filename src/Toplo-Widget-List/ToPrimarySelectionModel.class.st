Class {
	#name : #ToPrimarySelectionModel,
	#superclass : #ToFrontSelectionModel,
	#instVars : [
		'subSelectionModelIndex'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

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
