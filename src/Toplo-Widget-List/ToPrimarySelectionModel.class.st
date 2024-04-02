Class {
	#name : #ToPrimarySelectionModel,
	#superclass : #ToFrontSelectionModel,
	#instVars : [
		'subSelectionModelIndex'
	],
	#category : #'Toplo-Widget-List-Selection-Model'
}

{ #category : #copying }
ToPrimarySelectionModel >> duplicate [ 

	| cpy origSubSelectionModelIndex |
	cpy := self copy.
	origSubSelectionModelIndex := subSelectionModelIndex.
	cpy subSelectionModelIndex: IdentityDictionary new.
	subSelectionModelIndex keysAndValuesDo: [ :key :value |
		cpy subSelectionModelIndex at: key put: value copy ].
	^ cpy
	
]

{ #category : #initialization }
ToPrimarySelectionModel >> initialize [

	super initialize.
	subSelectionModelIndex := IdentityDictionary new
]

{ #category : #'instance creation' }
ToPrimarySelectionModel >> newSecondarySelectionModel [

	^ ToSecondarySelectionModel new
		  primarySelectionModel: self;
		  yourself
]

{ #category : #accessing }
ToPrimarySelectionModel >> subSelectionModelIndex [

	^ subSelectionModelIndex 
]

{ #category : #accessing }
ToPrimarySelectionModel >> subSelectionModelIndex: anIdentityDictionary [

	subSelectionModelIndex := anIdentityDictionary
]
